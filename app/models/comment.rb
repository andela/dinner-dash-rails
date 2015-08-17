class Comment < ActiveRecord::Base
  belongs_to :food
  belongs_to :user
  validates :food_id,  presence: true
  validates :user_id,  presence: true
end
