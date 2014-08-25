#http://railscasts.com/episodes/163-self-referential-association
class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "Occupation"
end
