class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.boolean :status
      t.float :price

      t.timestamps null: false
    end
  end
end
