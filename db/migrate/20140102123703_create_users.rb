class CreateUsers < ActiveRecord::Migration
  def change # def change determines the change to be made to the database
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
