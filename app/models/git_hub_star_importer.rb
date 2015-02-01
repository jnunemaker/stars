class GitHubStarImporter
  def initialize(user)
    @user = user
    @client = @user.github.client
    @nickname = @user.github.nickname
  end

  def import
    each_event do |event|
      star_event = StarEvent.find_or_create_for_event(event)

      begin
        UserStarEvent.ensure_imported(@user, star_event)
      rescue ActiveRecord::RecordInvalid => e
        p user: @user, star_event: star_event, event: event, exception: e
      end
    end
  end

  private

  def each_event
    with_auto_paginate do
      @client.received_public_events(@nickname).each do |octokit_event|
        event = GitHubEvent.from_octokit_event(octokit_event)
        yield event if event.import_for?(@nickname)
      end
    end
  end

  def with_auto_paginate
    original_auto_paginate = @client.auto_paginate
    @client.auto_paginate = true
    yield if block_given?
  ensure
    @client.auto_paginate = original_auto_paginate
  end
end
