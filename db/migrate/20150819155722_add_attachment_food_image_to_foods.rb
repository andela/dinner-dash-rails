class AddAttachmentFoodImageToFoods < ActiveRecord::Migration
  def self.up
    change_table :foods do |t|
      t.attachment :food_image
    end
  end

  def self.down
    remove_attachment :foods, :food_image
  end
end
