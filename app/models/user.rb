class User < ApplicationRecord
  	has_secure_password
	validates :email, presence: true, uniqueness: true
	validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }
	has_many :posts
	has_many :comments, dependent: :destroy

def self.search_by(search_term)
		where("LOWER(user_name LIKE :search_term OR 
			LOWER(email) LIKE :search_term",
		 search_term: "%#{search_term.downcase}%")
	end
end