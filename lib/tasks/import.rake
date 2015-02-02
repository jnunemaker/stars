task :import => :environment do
  User.find_each do |user|
    begin
      StarImporter.new(user).import
    rescue => e
      p user: user, exception: e
    end
  end
end
