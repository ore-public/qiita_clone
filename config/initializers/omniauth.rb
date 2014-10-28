Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.secrets.github['consumer_key'], Rails.application.secrets.github['consumer_secret']
end