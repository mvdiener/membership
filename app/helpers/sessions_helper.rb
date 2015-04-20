module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find(session[:current_user_id])
    end
  end

end