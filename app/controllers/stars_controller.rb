class StarsController < ApplicationController
  def index
    @star_events = current_user.star_events.order("id desc").page(params[:page]).per(50)
  end
end
