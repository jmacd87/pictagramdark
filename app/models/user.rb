class User < ApplicationRecord
  	has_secure_password
	validates :email, presence: true, uniqueness: true
	validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }
	has_many :posts
	has_many :comments, dependent: :destroy
end