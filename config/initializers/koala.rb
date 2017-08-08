Koala.configure do |config|
  config.app_id = Rails.application.secrets.facebook_app_id
  config.app_secret = Rails.application.secrets.facebook_app_secret
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
