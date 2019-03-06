class User < ApplicationRecord
  	has_secure_password
  	enum access_level: [:user, :superadmin]
	validates :email, presence: true, uniqueness: true
	validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }
	has_many :posts
	has_many :comments, dependent: :destroy

def self.search_by(search_term)
		where("LOWER(user_name LIKE :search_term OR 
			LOWER(email) LIKE :search_term",
		 search_term: "%#{search_term.downcase}%")
	end

	   def self.create_with_auth_and_hash(authentication, auth_hash)
        user = self.create!(
            first_name: auth_hash["info"]["first_name"],
            last_name: auth_hash["info"]["last_name"],
            email: auth_hash["info"]["email"],
            password: SecureRandom.hex(10),
        )
        user.authentications << authentication
        return user
    end

    # grab google to access google for user data
    def google_token
        x = self.authentications.find_by(provider: 'google_oauth2')
        return x.token unless x.nil?
    end
end 

