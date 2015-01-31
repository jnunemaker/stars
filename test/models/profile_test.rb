require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "for_provider_and_uid" do
    jnunemaker = profiles(:jnunemaker)
    assert_equal jnunemaker,
    Profile.for_provider_and_uid(Provider.github, jnunemaker.uid)
  end
end
