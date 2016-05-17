class User < ActiveRecord::Base
  validates :email, :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["prodiver"])
    if !user.nil?
      return user 
    else
      user = User.new
      user.uid = auth_hash["urls"]["uid"]
      user.provider = auth_hash["urls"]["provider"]
      user.name = auth_hash["info"]["name"]
      user.url = auth_hash["info"]["image"]
      user.profile_link = auth_hash["urls"]["spotify"]

      if user.save
        return user
      else
        return nil
      end
      
    end
  end
end
