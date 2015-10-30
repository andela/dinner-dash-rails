class FoodsController < ApplicationController
  before_action :check_if_admin,
                only: [:create, :destroy, :update, :edit_status]

  def index
    @foods = Food.all.order(created_at: :asc)
  end

  def new
    @food = Food.new
  end

  def edit
    @food = Food.find(params[:id])
    render template: "foods/new"
  end

  def create
    @food = {}
    if upload_image
      @food = Food.create(food_params)
      flash[:success] = "#{@food.name} has been added successfully."
      redirect_to dashboard_path
    else
      flash[:error] = "An error occured. Try adding #{@food.name} again."
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    upload_image if food_params[:food_image]
    if @food
      save_food
    else
      flash[:error] = "An error occured. Try adding #{@food.name} again."
    end
  end

  def destroy
    food = Food.find(params[:id])
    if food
      food.destroy
      flash[:success] = "#{food.name} has been deleted."
      redirect_to dashboard_path
    else
      flash[:error] = "An error occured. Try deleting #{@food.name} again."
    end
  end

  def edit_status
    food = Food.find(food_params[:id].to_i)
    unless food.nil?
      status = food_params[:status] == "true" ? "available" : "not available"
      food.status = status
      food.save
      render json: food
    end
  end

  private

  def food_params
    params.require(:food).permit(:id, :name, :description, :price,
                                 :category_id, :food_image, :status,:prep_time,
                                 sales: [:percentage, :price,
                                         :status, :js])
  end

  def upload_image
    image = food_params[:food_image]
    @food_image_url = false
    if image && image.size < 1.megabytes
      @upload = {}
      @upload[:food_image] = Cloudinary::Uploader.upload(image)
      @food_image_url = @upload[:food_image]["url"]
      @food[:food_image_file_name] = @food_image_url
    else
      flash[:warning] = "file size must be between 0 and 1 megabytes"
    end
    @food_image_url
  end

  def save_food
    @food[:food_image_file_name] = @food_image_url
    if food_params[:sales][:js]
      food = food_params[:sales]
      food_status = (food["status"] == "true") ? true : false
      @food.update(sales: { price: food["price"].to_f,
                            percentage: food["percentage"].to_f,
                            status: food_status })
      render json: { success: true }
    else
      @food.update(food_params)
      flash[:success] = "#{@food.name} has been updated successfully."
      redirect_to dashboard_path
    end
  end
end
