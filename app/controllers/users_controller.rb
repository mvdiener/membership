class UsersController < ApplicationController

  before_action :check_user, only: [:show]

  def new
    if current_user
      redirect_to(user_path(current_user), method: "GET")
    else
      @user = User.new
      render 'new'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to(user_path(current_user), method: "GET")
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(current_user)
    @passes = @user.passes
  end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end

    def check_user
      if params[:id].to_i != current_user.id
        redirect_to(user_path(current_user), method: "GET")
      end
    end

end