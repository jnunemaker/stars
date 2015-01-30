class SessionsController < ApplicationController
  def new
  end

  def create
    @auth = request.env['omniauth.auth']
  end

  def failure
    render text: "Failure :("
  end
end
