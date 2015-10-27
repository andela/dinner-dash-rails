module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    current_user
  end

  def admin?
    if logged_in?
     current_user.role == "admin"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def check_if_admin
    if admin?
      true
    else 
      redirect_to root_path
      flash[:danger] = "You do not have access to the Admin page"
    end
  end
end