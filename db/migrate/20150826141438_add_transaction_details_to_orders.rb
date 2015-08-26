class AddTransactionDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :transaction_id, :string
    add_column :orders, :invoice, :string
  end
end
