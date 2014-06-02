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

end
