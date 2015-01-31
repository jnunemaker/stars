class Profile < ActiveRecord::Base
  belongs_to :user

  def self.for_provider_and_uid(provider, uid)
    where(provider_id: provider.id, uid: uid).first
  end

  def self.github
    where(provider_id: Provider.github.id).first
  end

  def client
    @client ||= Octokit::Client.new(:access_token => token)
  end
end
