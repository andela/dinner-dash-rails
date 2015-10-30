class AddPreparationTimeToFood < ActiveRecord::Migration
  def change
    add_column :foods, :prep_time, :integer, :default => 12
  end
end
