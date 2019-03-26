module UsersHelper

	def self.search_by(search_term)
		where("LOWER(user_name LIKE :search_term OR 
			LOWER(email) LIKE :search_term",
		 search_term: "%#{search_term.downcase}%")
	end
end
