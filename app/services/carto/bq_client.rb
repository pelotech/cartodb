require 'signet/oauth_2/client'
require 'google/apis/bigquery_v2'

module Carto
  class BqClient
    SCOPES = %w(https://www.googleapis.com/auth/cloud-platform
      https://www.googleapis.com/auth/bigquery).freeze
    MAX_CLIENT_RETRIES = 3
    MAX_TIMEOUT = 3600
    ROWS_PER_PAGE = 10
    REQUEST_TIMEOUT_MS = 10000
    QUERY_TIMEOUT_MS = 3600000
    WAIT_JOB_SLEEP = 0.1

    def initialize(key)
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(key),
        scope: SCOPES)
      client_options = Google::Apis::ClientOptions.new
      client_options.open_timeout_sec = MAX_TIMEOUT
      client_options.read_timeout_sec = MAX_TIMEOUT
      request_options = Google::Apis::RequestOptions.new
      request_options.retries = MAX_CLIENT_RETRIES
      @service = Google::Apis::BigqueryV2::BigqueryService.new
      @service.client_options = client_options
      @service.request_options = request_options
      @service.authorization = authorizer
    end

    def table(dataset_id)
      project, dataset, table = dataset_id.split('.')
      @service.get_table(project, dataset, table)
    end

    def query(billing_project_id, sql, dry_run=false)
      job_config_query = Google::Apis::BigqueryV2::JobConfigurationQuery.new
      job_config_query.allow_large_results = true
      # job_config_query.destination_table = ... name of destination table must be defined for large results (>10 GB compressed)
      # job_config_query.maximum_billing_tier = ...
      # job_config_query.maximum_bytes_billed = ...
      # job_config_query.priority = ... 'INTERACTIVE'/'BATCH'
      job_config_query.query = sql
      job_config_query.use_legacy_sql = false
      job_config_query.use_query_cache = true

      job_config = Google::Apis::BigqueryV2::JobConfiguration.new
      job_config.dry_run = false
      job_config.query = job_config_query
      job_config.job_timeout_ms = QUERY_TIMEOUT_MS

      job = Google::Apis::BigqueryV2::Job.new(configuration: job_config)

      job = @service.insert_job(billing_project_id, job)
      job_id = job.id.split(':').last.split('.').last
      while job.status.state != 'DONE' # RUNNING
        # TODO: timeout here too?
        sleep WAIT_JOB_SLEEP
        job = @service.get_job(billing_project_id, job_id)
      end

      if job.status.error_result.present?
        @logger.append "BQ job #{job.job_reference} error #{job.status.error_result.reason}:\n#{job.status.error_result.message}"
        raise "BQ eror #{job.status.error_result.reason}"
      end

      #<Google::Apis::BigqueryV2::JobStatus:0x00007fe910fc2258 @state="DONE", @error_result=#<Google::Apis::BigqueryV2::ErrorProto:0x00007fe91265edb8 @message="Response too large to return. Consider setting allowLargeResults to true in your job configuration. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors", @reason="responseTooLarge">, @errors=[#<Google::Apis::BigqueryV2::ErrorProto:0x00007fe91265c2e8 @message="Response too large to return. Consider setting allowLargeResults to true in your job configuration. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors", @reason="responseTooLarge">]>
      # job.status.state == 'DONE'
      # job.status.error_result.present?
      # job.status.error_result.message == "Response too large to return. Consider setting allowLargeResults to true in your job configuration. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors"
      # job.status.error_result.reason == "responseTooLarge"
      # a call to get_job_query_results now would raise an exception # Google::Apis::ClientError Exception: responseTooLarge: Response too large to return. Consider setting allowLargeResults to true in your job configuration. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors
          # allow_large_results:
          # [Optional] If true and query uses legacy SQL dialect, allows the query to
          # produce arbitrarily large result tables at a slight cost in performance.
          # Requires destinationTable to be set. For standard SQL queries, this flag is
          # ignored and large results are always allowed. However, you must still set
          # destinationTable when result size exceeds the allowed maximum response size.
          # Corresponds to the JSON property `allowLargeResults`
          # @return [Boolean]
          # so, it must be we need to set a destinationTable...
          # Maximum response size — 10 GB compressed1
          #

      page_token = nil
      finished = false
      until finished
        result = @service.get_job_query_results(
          billing_project_id, job_id,
          max_results: ROWS_PER_PAGE,
          page_token: page_token,
          timeout_ms: REQUEST_TIMEOUT_MS
        )
        # result.cache_hit?
        # result.errors
        # result.job_complete?
        # result.page_token
        # result.rows
        # result.schema
        # result.total_rows
        result.rows.each do |row|
          yield row
        end
        page_token = result.page_token
        finished = page_token.nil?
      end
    end
  end
end
