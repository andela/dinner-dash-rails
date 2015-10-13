class AddOrderToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :order, index: true, foreign_key: true
  end
end
