class ProfileController < ApplicationController
  # Fetches property listings of logged in user
  def my_properties
    @user_id = current_user.id
    @properties = Property.where(:uid => @user_id)
  end
end
