class AddFoodToSales < ActiveRecord::Migration
  def change
    add_reference :sales, :food, index: true, foreign_key: true
  end
end
