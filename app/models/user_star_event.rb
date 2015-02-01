class UserStarEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :star_event

  States = {
    :pending => 1, # imported but not processed
  }

  StatesByValue = States.invert

  validates :star_event_id, presence: true
  validates :user_id, presence: true
  validates :state, presence: true, inclusion: States.values

  def self.ensure_imported(user, star_event)
    create!({
      state: States.fetch(:pending),
      user: user,
      star_event: star_event,
    })
  rescue ActiveRecord::RecordNotUnique
    nil
  end
end
