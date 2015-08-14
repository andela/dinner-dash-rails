class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :Status
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
