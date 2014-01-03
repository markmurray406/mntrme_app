class User < ActiveRecord::Base
# See Listing 6.20	
before_save { self.email = email.downcase }

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
end
