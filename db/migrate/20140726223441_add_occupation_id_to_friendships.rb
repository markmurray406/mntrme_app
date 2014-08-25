class AddOccupationIdToFriendships < ActiveRecord::Migration
  def change
  	add_column :friendships, :occupation_id, :integer
  end
end
