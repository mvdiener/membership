class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to(root_path)
    else
      render 'new'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end