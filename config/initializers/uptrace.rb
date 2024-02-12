# frozen_string_literal: true

require 'uptrace'
require 'opentelemetry-instrumentation-rails'
require 'opentelemetry-instrumentation-active_record'

# copy your project DSN here or use UPTRACE_DSN env var
Uptrace.configure_opentelemetry(dsn: ENV.fetch('UPTRACE_DSN', '')) do |c|
  # c is OpenTelemetry::SDK::Configurator
  c.use_all
  c.service_name = 'httpmock'
  c.service_version = ENV.fetch('VERSION', 'dev')
  c.resource = OpenTelemetry::SDK::Resources::Resource.create(
    OpenTelemetry::SemanticConventions::Resource::DEPLOYMENT_ENVIRONMENT => Rails.env.to_str
  )
end
