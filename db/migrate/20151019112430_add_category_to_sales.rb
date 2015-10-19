class AddCategoryToSales < ActiveRecord::Migration
  def change
    add_reference :sales, :category, index: true, foreign_key: true
  end
end
