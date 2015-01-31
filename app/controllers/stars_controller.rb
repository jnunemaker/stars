class StarsController < ApplicationController
  def index
    @events = github_client.received_events(github.nickname)
  end

  def github
    current_user.github
  end

  def github_client
    current_user.github_client
  end
end
