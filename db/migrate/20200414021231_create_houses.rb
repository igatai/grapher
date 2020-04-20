class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      # t.string :first_name
      t.string :Firstname
      # t.string :last_name
      t.string :Lastname
      # t.string :city
      t.string :City
      t.integer :num_of_people
      t.string :has_child
      t.timestamps
    end
  end
end
