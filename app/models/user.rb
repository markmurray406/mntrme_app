class User < ActiveRecord::Base
# See Listing 6.20	
before_save { self.email = email.downcase }
# See Listing 8.18
before_create :create_remember_token

# See Listign 6.6 
validates :name, presence: true, length: { maximum: 50 }
# See Listing 6.14
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
										# Orginal /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
								uniqueness: { case_sensitive: false }

# See Listing 6.26
has_secure_password
# See Listing 6.29
validates :password, length: { minimum: 6 }

	# See Listing 8.18 creates a before_create callback to create remember_token. 
	def User.new_remember_token
	 SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
	  Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
	  	self.remember_token = User.encrypt(User.new_remember_token)
		end
end
