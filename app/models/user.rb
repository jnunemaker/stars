class User < ActiveRecord::Base
  has_many :profiles

  def github
    @github ||= profiles.github
  end
end
