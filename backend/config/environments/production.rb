require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }
  config.active_support.report_deprecations = false
  config.cache_store = :memory_store
  config.active_record.dump_schema_after_migration = false
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/api/v1/health"

  config.hosts.clear
  ENV.fetch("APP_HOSTS", "coelho.wiki,www.coelho.wiki").split(",").each do |host|
    config.hosts << host.strip
  end

  config.assume_ssl = ActiveModel::Type::Boolean.new.cast(ENV.fetch("ASSUME_SSL", "true"))
  config.force_ssl = ActiveModel::Type::Boolean.new.cast(ENV.fetch("FORCE_SSL", "false"))
end
