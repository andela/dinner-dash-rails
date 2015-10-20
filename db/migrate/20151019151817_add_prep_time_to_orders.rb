class AddPrepTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pickup_time, :integer, default: 0
  end
end
