class Food < ActiveRecord::Base
  after_create :create_sale
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :comments
  serialize :sales

  has_attached_file :food_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "nigerian-jollof-rice.jpg"
  validates_attachment_content_type :food_image, :content_type => /\Aimage\/.*\Z/

  def create_sale
    self.sales = Hash.new
    sales[:price] = 0.00
    sales[:percentage] = 0
    sales[:status] = false
    save
  end
end
