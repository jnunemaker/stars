Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find_by_id(id)
end

Warden::Strategies.add(:stars) do
  def valid?
    request.env["omniauth.auth"].present?
  end

  def authenticate!
    authentication = Authentication.new(request.env["omniauth.auth"])

    if authentication.valid?
      success!(authentication.user)
    else
      fail("Could not sign in")
    end
  end
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :stars
  manager.failure_app = SessionsController.action(:new)
end
