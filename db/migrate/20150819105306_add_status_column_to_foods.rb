class AddStatusColumnToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :status, :string, :default => "available"
  end
end
