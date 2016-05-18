class SessionsController < ApplicationController



#   new: shows a view with OAuth sign-in link
  def new
  end
# create: accepts OAuth information from Spotify, finds or creates a User account, and sets user_id in session
    def create
    auth_hash = request.env['omniauth.auth']
    # raise
    @user = User.find_or_create_from_omniauth(auth_hash)
  #   if auth_hash["uid"]
  #     @user = User.find_or_create_from_omniauth(auth_hash)
      if @user
        session[:user_id] = @user.id
        redirect_to root_path
      else
        redirect_to root_path, notice: "Failed to save the user"
      end
    end

  
# destroy: deletes user_id from session
  def destroy
  end


end
