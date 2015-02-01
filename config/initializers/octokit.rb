if Rails.env.development?
  Octokit.middleware.response :logger
end
