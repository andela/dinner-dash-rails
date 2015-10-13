class AddCategoryIdToFood < ActiveRecord::Migration
  def change
    add_reference :foods, :category, index: true, foreign_key: true
  end
end
