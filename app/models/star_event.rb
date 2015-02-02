class StarEvent < ActiveRecord::Base
  has_many :user_star_events
  has_many :users, through: :user_star_events

  validates :event_id, presence: true

  def self.for_event_id(event_id)
    where(event_id: event_id).first
  end

  def self.find_or_create_for_event(event)
    create!({
      event_id: event.id,
      source: {
        "created_at"       => event.created_at,
        "actor_id"         => event.actor_id,
        "actor_login"      => event.actor_login,
        "actor_avatar_url" => event.actor_avatar_url,
        "repo_id"          => event.repo_id,
        "repo_name"        => event.repo_name,
      },
    })
  rescue ActiveRecord::RecordNotUnique
    for_event_id(event.id)
  end

  def actor_id
    source["actor_id"]
  end

  def actor_login
    source["actor_login"]
  end

  def actor_avatar_url
    source["actor_avatar_url"]
  end

  def actor_url
    "https://github.com/#{actor_login}"
  end

  def repo_id
    source["repo_id"]
  end

  def repo_name
    source["repo_name"]
  end

  def repo_url
    "https://github.com/#{repo_name}"
  end

  def event_created_at
    source["created_at"]
  end
end
