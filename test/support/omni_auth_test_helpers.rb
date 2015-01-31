module OmniAuthTestHelpers
  def auth_hash(hash = {})
    OmniAuth::AuthHash.new(hash)
  end

  def valid_auth_hash(hash = {})
    attributes = {
      provider: "github",
      uid: "1",
      info: {
        name: "John Nunemaker",
        nickname: "jnunemaker",
      },
      credentials: {
        token: "asdf",
      },
    }.merge(hash)

    auth_hash attributes
  end

  def invalid_auth_hash
    auth_hash provider: "github", uid: nil
  end
end
