class User < ActiveRecord::Base
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        puts user.to_json
        puts "==============="
        puts auth.to_json
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.password_digest = 'kdsalkdaslñkdsalkdñalkdslaklñdsa'
        user.save!
      end
    end
    has_secure_password
    has_many :pollas
    has_many :transactions
    validates_uniqueness_of :email
  end