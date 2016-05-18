class User < ActiveRecord::Base
  # validates :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if !user.nil?
      return user 
    else
      user = User.new
      user.uid = auth_hash["uid"]
      user.provider = auth_hash["provider"]
      user.name = auth_hash["info"]["name"]
      user.photo = auth_hash["info"]["image"]
      user.profile_link = auth_hash["info"]["urls"]["spotify"]
      user.email = auth_hash["info"]["email"]      

      if user.save
        return user
      else
        raise
        return nil
      end
      
    end
  end
end
