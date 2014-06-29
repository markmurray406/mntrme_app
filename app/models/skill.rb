class Skill < ActiveRecord::Base
	belongs_to :user
	belongs_to :occupation
	# See Listing 10.13
	has_many :resources, dependent: :destroy
	# See Listing 10.11
	default_scope -> { order('created_at DESC') }

	# See Listing 10.15
  validates :content, presence: true, length: { maximum: 140 }

	# See Listing 10.X
	validates :user_id, presence: true
	validates :occupation_id, presence: true
end
