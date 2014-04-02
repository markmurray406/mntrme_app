class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # See Listing 10.1
    add_index :occupations, [:user_id, :created_at]
  end
end
