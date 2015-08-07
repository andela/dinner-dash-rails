class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render "/app/views/layouts/_category.html.erb"
  end

  def show
    @category = Category.find(params[:id])
    render template: 'foods/index.html.erb'
  end
end
