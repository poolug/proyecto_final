Sentry.init do |config|
  config.dsn = 'https://171a3a95954c4da488bcceda7f1f80aa@o1180982.ingest.sentry.io/6294022'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  if Rails.env.production?
    config.traces_sample_rate = 1.0
    # or
    config.traces_sampler = lambda do |context|
      true
    end
  end
end