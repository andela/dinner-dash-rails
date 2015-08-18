class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }
  has_secure_password
   validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
   has_many :orders

  has_attached_file :avatar, styles: { :original => "150x150", :small => "64x64", :med => "200x200", :large => "300x300" }, :default_url => "yuna.jpg"
   validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
   validates_attachment_size :avatar, :in => 0.megabytes..1.megabytes

  has_many :comments

end
