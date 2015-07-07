class GitHubStarEventStream
  WatchEvent = "WatchEvent".freeze

  def initialize(user)
    @user = user
    @client = @user.github.client
    @client.auto_paginate = true
    @nickname = @user.github.nickname
    @nickname_regex = /^#{Regexp.escape(@nickname)}/i
  end

  def each(&block)
    @client.received_public_events(@nickname).reverse.each do |octokit_event|
      next if octokit_event.type != WatchEvent
      next if octokit_event.repo.name =~ @nickname_regex

      begin
        repository = @client.repo(octokit_event.repo.name)

        yield GitHubEvent.new({
          id: octokit_event.id,
          type: octokit_event.type,
          created_at: octokit_event.created_at.utc.iso8601,
          actor_id: octokit_event.actor.id,
          actor_login: octokit_event.actor.login,
          actor_avatar_url: octokit_event.actor.avatar_url,
          repo_id: octokit_event.repo.id,
          repo_name: octokit_event.repo.name,
          repo_description: repository["description"],
        })
      rescue => exception
        p nickname: @nickname, octokit_event: octokit_event, exception: exception, at: "get_repo"
      end
    end
  end
end
