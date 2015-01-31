require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "GET callback valid" do
    request.env["omniauth.auth"] = valid_auth_hash
    get :callback, provider: "github"
    assert_equal users(:jnunemaker), warden.user
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "GET callback invalid" do
    request.env["omniauth.auth"] = invalid_auth_hash
    get :callback, provider: "github"
    assert_response :redirect
    assert_redirected_to auth_failure_path
  end

  test "DELETE destroy" do
    user = users(:jnunemaker)
    sign_in user
    delete :destroy
    assert_nil warden.user
    assert_template :destroy
  end

  test "GET failure" do
    get :failure
    assert_response 401
    assert_template :failure
  end

  test "GET no_access" do
    get :no_access
    assert_response 401
    assert_template :no_access
  end
end
