stack = Faraday::RackBuilder.new do |builder|
  builder.response :logger
  builder.use Octokit::Response::RaiseError
  builder.use Octokit::Response::FeedParser
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack
