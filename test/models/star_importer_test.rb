require 'test_helper'

class StarImporterTest < ActiveSupport::TestCase
  test "imports star events not for owned repositories" do
    stub_request(:get, "https://api.github.com/users/jnunemaker/received_events/public?per_page=100").
      to_return(fixture_file("public_received_events.txt"))
    stub_request(:get, "https://api.github.com/user/235/received_events/public?page=2&per_page=100").
      to_return(fixture_file("public_received_events_2.txt"))
    stub_request(:get, "https://api.github.com/user/235/received_events/public?page=3&per_page=100").
      to_return(fixture_file("public_received_events_3.txt"))
    stub_request(:get, /https:\/\/api.github.com\/repos\/.*\/.*/)


    user = users(:jnunemaker)
    importer = StarImporter.new(user)

    assert_difference "StarEvent.count", 114 do
      assert_difference "UserStarEvent.count", 114 do
        importer.import
      end
    end
  end
end
