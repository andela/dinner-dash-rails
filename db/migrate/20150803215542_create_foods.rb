class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.string :description
      t.float :price
      t.timestamps null: false
      t.belongs_to :category
    end
  end
end
