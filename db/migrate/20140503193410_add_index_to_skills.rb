class AddIndexToSkills < ActiveRecord::Migration
  def change
  	add_index :skills, [:skill_id, :created_at]
  end
end
