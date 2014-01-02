class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	# See Listing 6.19
  	add_index :users, :email, unique: true
  end
end
