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
        "repo_description" => event.repo_description,
      },
    })
  rescue ActiveRecord::RecordNotUnique
    for_event_id(event.id)
  end

  def actor_id
    if source
      source["actor_id"]
    end
  end

  def actor_login
    if source
      source["actor_login"]
    end
  end

  def actor_avatar_url
    if source
      source["actor_avatar_url"]
    end
  end

  def actor_url
    "https://github.com/#{actor_login}"
  end

  def repo_id
    if source
      source["repo_id"]
    end
  end

  def repo_name
    if source
      source["repo_name"]
    end
  end

  def repo_description
    if source
      source["repo_description"]
    end
  end

  def repo_url
    "https://github.com/#{repo_name}"
  end

  def event_created_at
    if source
      source["created_at"]
    end
  end
end
