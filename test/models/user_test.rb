require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "relationships" do
    user = users(:jnunemaker)
    assert user.profiles.include?(profiles(:jnunemaker))
    assert user.star_events.include?(star_events(:bkeepers))
  end
end
