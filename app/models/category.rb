class Category < ActiveRecord::Base
  has_many :foods
  has_one :sale
end
