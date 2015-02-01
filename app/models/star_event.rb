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
end
