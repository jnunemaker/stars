class GitHubEvent
  attr_reader :id
  attr_reader :type
  attr_reader :created_at

  attr_reader :actor_id
  attr_reader :actor_login
  attr_reader :actor_avatar_url

  attr_reader :repo_id
  attr_reader :repo_name
  attr_reader :repo_description

  def initialize(attrs = {})
    @id               = attrs.fetch(:id)
    @type             = attrs.fetch(:type)
    @created_at       = attrs.fetch(:created_at)
    @actor_id         = attrs.fetch(:actor_id)
    @actor_login      = attrs.fetch(:actor_login)
    @actor_avatar_url = attrs.fetch(:actor_avatar_url)
    @repo_id          = attrs.fetch(:repo_id)
    @repo_name        = attrs.fetch(:repo_name)
    @repo_description = attrs.fetch(:repo_description)
  end
end
