class Resource < ActiveRecord::Base
	# See Listing 10.7
	belongs_to :user
	belongs_to :skill
	# See Listing 10.11
	default_scope -> { order('created_at DESC') }
	# See Listing 10.15
	validates :content, presence: true, length: { maximum: 140 }
	# See Listing 10.4
	validates :user_id, presence: true
	validates :skill_id, presence: true
end
