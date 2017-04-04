class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:get_user]

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  def get_user
    graph_data = params[:graph_data]
    @user = User.from_android(graph_data)
  end
end
