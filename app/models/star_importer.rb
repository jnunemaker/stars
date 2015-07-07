class StarImporter
  def initialize(user)
    @user = user
    @stream = GitHubStarEventStream.new(@user)
  end

  def import
    @stream.each do |event|
      star_event = StarEvent.find_or_create_for_event(event)

      begin
        UserStarEvent.ensure_imported(@user, star_event)
      rescue ActiveRecord::RecordInvalid => e
        p user: @user, star_event: star_event, event: event, exception: e, at: "ensure_imported"
        pp e.backtrace
      end
    end
  end
end
