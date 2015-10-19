class AddDefaultToSales < ActiveRecord::Migration
  def change
    change_column :sales, :status, :boolean, :default => false
  end
end
