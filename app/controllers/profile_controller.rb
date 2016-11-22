class ProfileController < ApplicationController

  def show_profile
    if current_user == nil
      redirect_to root_path, flash: {error: "You need to be logged in to do that!"}
    else
      @user = User.find(params[:id])
    end
  end

  def edit_profile
    @profile_to_edit = User.find(params[:id])
    if @profile_to_edit != current_user
      redirect_to root_path, flash: {error: "You need to be logged in as the correct user to do that!"}
    end
  end


  # Fetches property listings of logged in user
  def my_properties
    @user_id = current_user.id
    @properties = Property.where(:uid => @user_id)
  end
end