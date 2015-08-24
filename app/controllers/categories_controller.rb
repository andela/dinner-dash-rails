class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render "/app/views/layouts/_category.html.erb"
  end
  def new
    @category = Category.new
  end
  def create
    if @current_user.role == "admin"
      @category = Category.create(category_params)
      if @category
        flash[:success] = "New category Created"
        redirect_to admin_foods_path
      else
        flash[:failure] = "Error in creating category"
      end
    end
  end
  def show
    @category = Category.find(params[:id])
    render template: 'foods/index.html.erb'
  end
  def category_params
    params.require(:category).permit(:title, :description)
  end
end
