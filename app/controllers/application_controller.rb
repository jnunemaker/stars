class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate!

  private

  def warden
    request.env["warden"]
  end

  def authenticate!(*args)
    warden.authenticate! *args
  end

  def authenticated?(*args)
    warden.authenticated? *args
  end
  alias_method :signed_in?, :authenticated?
  helper_method :authenticated?, :signed_in?

  def current_user(*args)
    warden.user *args
  end
  helper_method :current_user

  # Public: Sign in a user if the user is truthy.
  def sign_in(*args)
    warden.set_user *args
  end

  # Public: Sign out the currently signed in user.
  def sign_out(*args)
    warden.logout(*args)
  end
end
