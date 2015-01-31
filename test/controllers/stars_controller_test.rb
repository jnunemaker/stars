require 'test_helper'

class StarsControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in users(:jnunemaker)
    get :index
    assert_response :success
  end
end
