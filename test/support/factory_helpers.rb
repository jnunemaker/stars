module FactoryHelpers
  def build(which, attrs = {})
    method_name = "build_#{which}"
    if respond_to?(method_name)
      send(method_name)
    end
  end

  def create(which, attrs = {})
    build(which, attrs).tap { |record| record.save! }
  end

  def build_star_event(attrs = {})
    StarEvent.new({
      event_id: "2550646448",
      source: {
        "repo_id" => "28513398",
        "actor_id" => "1258",
        "repo_name" => "MengTo/Spring",
        "created_at" => Time.now.utc.iso8601,
        "actor_login" => "bryanveloso",
        "actor_avatar_url" => "https://avatars.githubusercontent.com/u/1258?",
      },
    }.merge(attrs))
  end

  def build_github_event(attrs = {})
    GitHubEvent.new({
      id: "2550646448",
      type: "WatchEvent",
      repo_id: "28513398",
      actor_id: "1258",
      repo_name: "MengTo/Spring",
      created_at: Time.now.utc.iso8601,
      actor_login: "bryanveloso",
      actor_avatar_url: "https://avatars.githubusercontent.com/u/1258?",
    }.merge(attrs))
  end
end
