class GitHubEvent
  WatchEvent = "WatchEvent"

  def self.from_octokit_event(octokit_event)
    new({
      id: octokit_event.id,
      type: octokit_event.type,
      created_at: octokit_event.created_at.utc.iso8601,
      actor_id: octokit_event.actor.id,
      actor_login: octokit_event.actor.login,
      actor_avatar_url: octokit_event.actor.avatar_url,
      repo_id: octokit_event.repo.id,
      repo_name: octokit_event.repo.name,
    })
  end

  attr_reader :id
  attr_reader :type
  attr_reader :created_at

  attr_reader :actor_id
  attr_reader :actor_login
  attr_reader :actor_avatar_url

  attr_reader :repo_id
  attr_reader :repo_name

  def initialize(attrs = {})
    @id               = attrs.fetch(:id)
    @type             = attrs.fetch(:type)
    @created_at       = attrs.fetch(:created_at)
    @actor_id         = attrs.fetch(:actor_id)
    @actor_login      = attrs.fetch(:actor_login)
    @actor_avatar_url = attrs.fetch(:actor_avatar_url)
    @repo_id          = attrs.fetch(:repo_id)
    @repo_name        = attrs.fetch(:repo_name)
  end

  def import_for?(nickname)
    star? && !repository_owner?(nickname)
  end

  private

  def star?
    @type == WatchEvent
  end

  def repository_owner?(nickname)
    @repo_name =~ /^#{Regexp.escape(nickname)}/i
  end
end
