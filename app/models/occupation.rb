class Occupation < ActiveRecord::Base
	# See Listing 10.7
	belongs_to :user
	# See Listing 10.13
	has_many :skills, dependent: :destroy
	# See Listing 10.11
	default_scope -> { order('created_at DESC') }
	# See Listing 10.4
	validates :user_id, presence: true
	# See Listing 10.15
	validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

	# Simple Search Form. See http://railscasts.com/episodes/37-simple-search-form
	def self.search(search)
  	if search
    	find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
  	else
    	find(:all)
  	end
	end

end
