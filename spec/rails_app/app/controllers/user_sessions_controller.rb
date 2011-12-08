class UserSessionsController < ApplicationController
  
  def show
    render :text => current_user_id.to_s
  end
  def create
    session[:current_user_id] = params[:user_id]
  end
  def set_manually
    session[:current_user_id] = params[:user_id]
    render :text => current_user_id.to_s
  end

end