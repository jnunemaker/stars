task :import do
  User.find_each do |user|
    begin
      GitHubStarImporter.new(user).import
    rescue => e
      p user: user, exception: e
    end
  end
end
