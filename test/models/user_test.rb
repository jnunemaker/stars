require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "relationships" do
    user = users(:jnunemaker)
    assert user.profiles.include?(profiles(:jnunemaker))
  end
end
