class User < ActiveRecord::Base
# See Listing 10.8	
has_many :occupations, dependent: :destroy
has_many :skills, dependent: :destroy
has_many :resources

# See 8 minutes, http://railscasts.com/episodes/163-self-referential-association
has_many :friendships
has_many :friends, :through => :friendships

# Showing People who want the occupation
has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
has_many :inverse_friends, :through => :inverse_friendships, :source => :user

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

  # See Listing 10.36
	def feed
    # This is preliminary. See "Following users" for the full implementation.
    Occupation.where("user_id = ?", id)
  end

	# Simple Search Form. See http://railscasts.com/episodes/37-simple-search-form
	def self.search(search)
  	if search
    	find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  	else
    	find(:all)
  	end
	end
	
	# End of Simple Serch Form.
	private

		def create_remember_token
	  	self.remember_token = User.encrypt(User.new_remember_token)
		end
end
