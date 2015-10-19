class SalesController < ApplicationController
  def new
    @sale = Sale.new
    @items = Food.allsale
  end

  def create

  end
end
