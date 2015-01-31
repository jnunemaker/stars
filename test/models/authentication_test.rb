require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  test "authentication for existing profile" do
    authentication = Authentication.new(valid_auth_hash)

    assert_no_difference 'User.count' do
      assert_no_difference 'Profile.count' do
        assert_equal users(:jnunemaker), authentication.user
      end
    end
  end

  test "authentication for new profile" do
    authentication = Authentication.new(valid_auth_hash({
      uid: "12345",
      info: {
        nickname: 'frank',
      },
    }))

    assert_difference 'User.count' do
      assert_difference 'Profile.count' do
        user = authentication.user
        profile = Profile.for_provider_and_uid(Provider.github, "12345")
        assert_equal User.last, profile.user
      end
    end
  end

  test "valid?" do
    authentication = Authentication.new(valid_auth_hash)
    assert_equal true, authentication.valid?

    authentication = Authentication.new(invalid_auth_hash)
    assert_equal false, authentication.valid?
  end
end
