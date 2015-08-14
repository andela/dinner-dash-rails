class Order < ActiveRecord::Base
  has_many :order_items
  has_many :foods, through: :order_items
  belongs_to :user
end
