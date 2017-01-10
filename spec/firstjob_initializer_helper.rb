FirstjobApi.setup do |config|
  config.username = ENV["FIRSTJOB_USERNAME"]
  config.password = ENV["FIRSTJOB_PASSWORD"]
  config.base_uri ENV["FIRSTJOB_BASE_URI"]
end
