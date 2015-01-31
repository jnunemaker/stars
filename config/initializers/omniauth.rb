Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV.fetch("GITHUB_KEY"), ENV.fetch("GITHUB_SECRET")
end
