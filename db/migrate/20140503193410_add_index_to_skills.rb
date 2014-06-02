class AddIndexToSkills < ActiveRecord::Migration
  def change
  	add_index :skills, [:occupation_id, :created_at]
  end
end
