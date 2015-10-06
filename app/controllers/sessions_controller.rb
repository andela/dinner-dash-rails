class SessionsController < ApplicationController
  def new
    session[:referrer] = request.referer
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      if admin?
        redirect_to dashboard_path
      else
        redirect_to session[:referrer]
      end
    else
      flash.now[:danger] = "Invalid email/password confirmation"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to foods_path
  end
end
