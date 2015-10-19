class Sale < ActiveRecord::Base
  belongs_to :food
  belongs_to :category
end
