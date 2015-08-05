class FoodsController < ApplicationController
  def index
    @foods = Food.all
    # args = food_params
    # @foods = args.nil? ? Food.all : Task.where(args).order(name: :desc)
    # if @foods
    #   @foods
    # else
    #   render html: "No food has been created yet"
    # end
  end

  def new
    @food = Food.new
  end

  def create
    args = food_params
    if @admin
      food = Task.create(args)
      render !food.respond_to?('errors') || food.errors.empty? ? food : "Error! #{food.errors.messages}"
    else
      render html: "Only an administrator can create a food item"
    end
  end

  def show
    @food = Food.find(food_params[:id])
  end

  def update
    args = food_params
    if @admin
      food = Food.find(food_params[:id])
      if !food.nil?
        render html: food.update(args) ? "Food updated successfully" : "Error! #{food.errors.messages}"
      else
        render html: "Food with id: #{food_params[:id]} doesn't exist!"
      end
    else
      render html: "You have to be an admin to edit food!"
    end
  end

  def destroy
    if @admin
      food = Food.find(food_params[:id])
      if !food.nil?
        render html: food.destroy! ? flash[:notice]="Food deleted successfully" : "Error! #{food.errors.messages}"
      else
        render html: "Food with id: #{food_params[:id]} doesn't exist!"
      end
    else
      render html: "You have to be an admin to delete food!"
    end
  end

  private

  def food_params
    require params.require(:food).permit(:id, :name, :description, :price, :category_id)

  end
end
