class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :content
      t.integer :user_id
      t.integer :occupation_id

      t.timestamps
    end
    # See Listing 10.1
    add_index :skills, [:occupation_id, :created_at]
  end
end
