class AddSalesToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :sales, :text
  end
end
