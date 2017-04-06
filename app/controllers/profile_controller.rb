class ProfileController < ApplicationController

  def show_profile
    if current_user == nil
      redirect_to root_path, flash: {error: "You need to be logged in to do that!"}
    else
      begin
        @user = User.find(params[:id])
        @properties = Property.where(:uid => @user.id)
      rescue
        redirect_to root_path, flash: {error: "User does not exist"}
      end
    end
  end


  def show_profile_json
    fbid = params[:id]
    @user = User.where(:uid => fbid )[0]
  end

  def edit_profile
    if current_user == nil
      redirect_to root_path, flash: {error: "You need to be logged in to do that!"}
    else
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to root_path, flash: {error: "User does not exist"}
      end
    end
  end
end
