class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :Status, :default => "pending"
      t.integer :total
      t.integer :vat
      t.integer :delivery_cost

      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
