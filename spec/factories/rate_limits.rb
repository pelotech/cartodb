FactoryBot.define do
  factory :rate_limits, class: 'Carto::RateLimit' do
    maps_anonymous        { Carto::RateLimitValues.new([0, 1, 2]) }
    maps_static           { Carto::RateLimitValues.new([3, 4, 5]) }
    maps_static_named     { Carto::RateLimitValues.new([6, 7, 8]) }
    maps_dataview         { Carto::RateLimitValues.new([9, 10, 11]) }
    maps_dataview_search  { Carto::RateLimitValues.new([9, 10, 11]) }
    maps_analysis         { Carto::RateLimitValues.new([12, 13, 14]) }
    maps_tile             { Carto::RateLimitValues.new([15, 16, 17, 30, 32, 34]) }
    maps_attributes       { Carto::RateLimitValues.new([18, 19, 20]) }
    maps_named_list       { Carto::RateLimitValues.new([21, 22, 23]) }
    maps_named_create     { Carto::RateLimitValues.new([24, 25, 26]) }
    maps_named_get        { Carto::RateLimitValues.new([27, 28, 29]) }
    maps_named            { Carto::RateLimitValues.new([30, 31, 32]) }
    maps_named_update     { Carto::RateLimitValues.new([33, 34, 35]) }
    maps_named_delete     { Carto::RateLimitValues.new([36, 37, 38]) }
    maps_named_tiles      { Carto::RateLimitValues.new([39, 40, 41]) }
    maps_analysis_catalog { Carto::RateLimitValues.new([1, 1, 1]) }
    sql_query             { Carto::RateLimitValues.new([0, 1, 2]) }
    sql_query_format      { Carto::RateLimitValues.new([3, 4, 5]) }
    sql_job_create        { Carto::RateLimitValues.new([6, 7, 8]) }
    sql_job_get           { Carto::RateLimitValues.new([9, 10, 11]) }
    sql_job_delete        { Carto::RateLimitValues.new([12, 13, 14]) }
    sql_copy_from         { Carto::RateLimitValues.new([1, 1, 60]) }
    sql_copy_to           { Carto::RateLimitValues.new([1, 1, 60]) }
  end

  factory :rate_limits_custom, class: 'Carto::RateLimit' do
    maps_anonymous        { Carto::RateLimitValues.new([10, 11, 12]) }
    maps_static           { Carto::RateLimitValues.new([13, 14, 15]) }
    maps_static_named     { Carto::RateLimitValues.new([16, 17, 18]) }
    maps_dataview         { Carto::RateLimitValues.new([19, 110, 111]) }
    maps_dataview_search  { Carto::RateLimitValues.new([19, 110, 111]) }
    maps_analysis         { Carto::RateLimitValues.new([112, 113, 114]) }
    maps_tile             { Carto::RateLimitValues.new([115, 116, 117, 230, 232, 234]) }
    maps_attributes       { Carto::RateLimitValues.new([118, 119, 120]) }
    maps_named_list       { Carto::RateLimitValues.new([121, 122, 123]) }
    maps_named_create     { Carto::RateLimitValues.new([124, 125, 126]) }
    maps_named_get        { Carto::RateLimitValues.new([127, 128, 129]) }
    maps_named            { Carto::RateLimitValues.new([130, 131, 132]) }
    maps_named_update     { Carto::RateLimitValues.new([133, 134, 135]) }
    maps_named_delete     { Carto::RateLimitValues.new([136, 137, 138]) }
    maps_named_tiles      { Carto::RateLimitValues.new([139, 140, 141]) }
    maps_analysis_catalog { Carto::RateLimitValues.new([11, 11, 11]) }
    sql_query             { Carto::RateLimitValues.new([10, 11, 12]) }
    sql_query_format      { Carto::RateLimitValues.new([13, 14, 15]) }
    sql_job_create        { Carto::RateLimitValues.new([16, 17, 18]) }
    sql_job_get           { Carto::RateLimitValues.new([19, 110, 111]) }
    sql_job_delete        { Carto::RateLimitValues.new([112, 113, 114]) }
    sql_copy_from         { Carto::RateLimitValues.new([11, 11, 160]) }
    sql_copy_to           { Carto::RateLimitValues.new([11, 11, 160]) }
  end

  factory :rate_limits_custom2, class: 'Carto::RateLimit' do
    maps_anonymous        { Carto::RateLimitValues.new([10, 11, 12]) }
    maps_static           { Carto::RateLimitValues.new([13, 14, 15]) }
    maps_static_named     { Carto::RateLimitValues.new([16, 17, 18]) }
    maps_dataview         { Carto::RateLimitValues.new([19, 110, 111]) }
    maps_dataview_search  { Carto::RateLimitValues.new([19, 110, 111]) }
    maps_analysis         { Carto::RateLimitValues.new([112, 113, 114]) }
    maps_tile             { Carto::RateLimitValues.new([115, 116, 117, 230, 232, 234]) }
    maps_attributes       { Carto::RateLimitValues.new([118, 119, 120]) }
    maps_named_list       { Carto::RateLimitValues.new([121, 122, 123]) }
    maps_named_create     { Carto::RateLimitValues.new([124, 125, 126]) }
    maps_named_get        { Carto::RateLimitValues.new([127, 128, 129]) }
    maps_named            { Carto::RateLimitValues.new([130, 131, 132]) }
    maps_named_update     { Carto::RateLimitValues.new([133, 134, 135]) }
    maps_named_delete     { Carto::RateLimitValues.new([136, 137, 138]) }
    maps_named_tiles      { Carto::RateLimitValues.new([139, 140, 141]) }
    maps_analysis_catalog { Carto::RateLimitValues.new([11, 11, 11]) }
    sql_query             { Carto::RateLimitValues.new([10, 11, 12]) }
    sql_query_format      { Carto::RateLimitValues.new([13, 14, 15]) }
    sql_job_create        { Carto::RateLimitValues.new([16, 17, 18]) }
    sql_job_get           { Carto::RateLimitValues.new([19, 110, 111]) }
    sql_job_delete        { Carto::RateLimitValues.new([112, 113, 114]) }
    sql_copy_from         { Carto::RateLimitValues.new([112, 112, 161]) }
    sql_copy_to           { Carto::RateLimitValues.new([112, 112, 161]) }
  end

  factory :rate_limits_pro, class: 'Carto::RateLimit' do
    maps_anonymous        { Carto::RateLimitValues.new([1, 1, 2]) }
    maps_static           { Carto::RateLimitValues.new([2, 4, 5]) }
    maps_static_named     { Carto::RateLimitValues.new([3, 7, 8]) }
    maps_dataview         { Carto::RateLimitValues.new([4, 10, 11]) }
    maps_dataview_search  { Carto::RateLimitValues.new([4, 10, 11]) }
    maps_analysis         { Carto::RateLimitValues.new([5, 13, 14]) }
    maps_tile             { Carto::RateLimitValues.new([6, 16, 17, 30, 32, 34]) }
    maps_attributes       { Carto::RateLimitValues.new([7, 19, 20]) }
    maps_named_list       { Carto::RateLimitValues.new([8, 22, 23]) }
    maps_named_create     { Carto::RateLimitValues.new([9, 25, 26]) }
    maps_named_get        { Carto::RateLimitValues.new([10, 28, 29]) }
    maps_named            { Carto::RateLimitValues.new([11, 31, 32]) }
    maps_named_update     { Carto::RateLimitValues.new([12, 34, 35]) }
    maps_named_delete     { Carto::RateLimitValues.new([13, 37, 38]) }
    maps_named_tiles      { Carto::RateLimitValues.new([14, 40, 41]) }
    maps_analysis_catalog { Carto::RateLimitValues.new([111, 111, 111]) }
    sql_query             { Carto::RateLimitValues.new([1, 1, 2]) }
    sql_query_format      { Carto::RateLimitValues.new([2, 4, 5]) }
    sql_job_create        { Carto::RateLimitValues.new([3, 7, 8]) }
    sql_job_get           { Carto::RateLimitValues.new([4, 10, 11]) }
    sql_job_delete        { Carto::RateLimitValues.new([5, 13, 14]) }
    sql_copy_from         { Carto::RateLimitValues.new([2, 2, 61]) }
    sql_copy_to           { Carto::RateLimitValues.new([2, 2, 61]) }
  end
end
