class SalesController < ApplicationController
  def new
    @items = []
    Food.all.each do |food|
      @items << food unless food.sales[:status]
    end
  end
end
