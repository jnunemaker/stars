class User < ActiveRecord::Base
  has_many :profiles
  has_many :user_star_events
  has_many :star_events, through: :user_star_events

  def github
    @github ||= profiles.github
  end
end
