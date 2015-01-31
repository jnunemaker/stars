class SessionsController < UnauthenticatedController
  def new
    redirect_to "/auth/github"
  end

  def callback
    authentication = Authentication.new(request.env["omniauth.auth"])

    if authentication.valid?
      sign_in authentication.user
      redirect_to root_path
    else
      redirect_to auth_failure_path
    end
  end

  def destroy
    sign_out
  end

  def failure
    render :status => 401
  end

  def no_access
    render :status => 401
  end
end
