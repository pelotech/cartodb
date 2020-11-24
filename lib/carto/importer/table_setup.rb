module Carto
  module Importer
    class TableSetup

      include ::LoggerHelper

      STATEMENT_TIMEOUT = 1.hour * 1000

      def initialize(user:, overviews_creator:, log:, statement_timeout: STATEMENT_TIMEOUT)
        @user = user
        @overviews_creator = overviews_creator
        @log = log
        @statement_timeout = statement_timeout
      end

      # Store all properties from the table to re-create them after "syncing" the table by reimporting and swapping it
      def generate_table_statements(origin_schema, origin_table_name)
        @user.in_database(as: :superuser)[%(
            SELECT cartodb.CDB_GetTableQueries(
                            concat(quote_ident('#{origin_schema}'), '.', quote_ident('#{origin_table_name}'))::regclass::oid,
                            ignore_cartodbfication := true)
          )]
      end

      def run_table_statements(statements, database)
        begin
          database.run([%(
            SELECT cartodb.CDB_ApplyQueriesSafe(#{statements})
                      )])
          rescue StandardError => e
            log_error(exception: e)
          end
      end

      def cartodbfy(table_name)
        schema_name = @user.database_schema
        qualified_table_name = "\"#{schema_name}\".#{table_name}"

        @user.transaction_with_timeout(statement_timeout: @statement_timeout) do |user_conn|
          user_conn.run(%{
            SELECT cartodb.CDB_CartodbfyTable('#{schema_name}'::TEXT,'#{qualified_table_name}'::REGCLASS);
          })
        end

        update_table_pg_stats(qualified_table_name)
      rescue StandardError => e
        log_error(message: 'Error in sync cartodbfy', exception: e, table: { name: table_name })
        raise e
      end

      def fix_oid(table_name)
        user_table = Carto::UserTable.find(@user.tables.where(name: table_name).first.id)

        user_table.sync_table_id
        user_table.save
      end

      def update_table_pg_stats(qualified_table_name)
        @user.transaction_with_timeout(statement_timeout: @statement_timeout) do |user_conn|
          user_conn.run(%{
            ANALYZE #{qualified_table_name};
          })
        end
      end

      def update_cdb_tablemetadata(name)
        @user.tables.where(name: name).first.update_cdb_tablemetadata
      end

      private

      def log_context
        super.merge(current_user: @user)
      end
    end
  end
end
