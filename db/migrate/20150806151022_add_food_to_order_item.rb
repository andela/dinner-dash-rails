class AddFoodToOrderItem < ActiveRecord::Migration
  def change
    add_reference :order_items, :food, index: true, foreign_key: true
  end
end
