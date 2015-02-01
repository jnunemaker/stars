class Authentication

  # Public: Returns an authentication instance.
  #
  # auth - The omniauth auth instance (with uid and credentials).
  def initialize(auth)
    @auth = auth
  end

  # Public
  #
  # Returns true if successfully persisted user exists, else false.
  def valid?
    uid.present? && info.present? && nickname.present? && user && user.persisted?
  end

  # Public: Returns the user based on the auth information.
  def user
    return @user if defined?(@user)

    profile = Profile.for_provider_and_uid(provider, uid)

    if profile.blank?
      User.transaction do
        @user = User.create!

        profile = @user.profiles.create!({
          provider_id: provider.id,
          uid: uid,
          nickname: nickname,
          token: credentials["token"],
          secret: credentials["secret"],
          expires: credentials["expires"],
          expires_at: credentials["expires_at"],
        })
      end
    else
      profile.update_attributes({
        nickname: nickname,
        token: credentials["token"],
        secret: credentials["secret"],
        expires: credentials["expires"],
        expires_at: credentials["expires_at"],
      })
      @user = profile.user
    end

    @user
  end

  private

  def provider
    @provider ||= Provider.find_by_name(@auth.provider)
  end

  def credentials
    @credentials ||= @auth.credentials
  end

  def uid
    @uid ||= @auth.uid
  end

  def info
    @info ||= @auth.info
  end

  def nickname
    @nickname ||= info["nickname"]
  end
end
