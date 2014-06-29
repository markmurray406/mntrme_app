class AddSkillIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :skill_id, :integer
  end
end
