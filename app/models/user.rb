class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 },
                   uniqueness: true
  validates :introduction, length: { maximum: 50 }                 

end
