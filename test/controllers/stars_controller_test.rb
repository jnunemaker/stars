require 'test_helper'

class StarsControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in users(:jnunemaker)
    @controller.github_client.
      expects(:received_events).with("jnunemaker").returns([])
    get :index
    assert_response :success
  end
end
