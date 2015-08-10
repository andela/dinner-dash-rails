class Food < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
end
