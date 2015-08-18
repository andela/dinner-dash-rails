class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    upload_image(params[:user][:avatar]) if params[:user][:avatar]
    @user[:avatar_file_name] = @avatar_url
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{user_params[:first_name]} to dinner dash!"
      redirect_to root_path
    else
      flash[:error] = "One or more required fields are missing"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    args = args_params
    if !args.nil?
      @orders = @user.orders
      @title = args[:title]
    else
      @orders = @user.orders.limit(3)
      @title = "Recent Orders"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Successfully Updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def upload_image(text)
    @upload = {}
    @upload[:avatar] = Cloudinary::Uploader.upload(text)
    @avatar_url = @upload[:avatar]["url"]
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end

  def args_params
    args = params.require(:args).permit(:show_all, :title) if params.has_key? "args"
  end
end
