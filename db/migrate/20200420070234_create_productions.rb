class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.integer :Label
      t.references :house, foreign_key: true
      # t.references :House, foreign_key: true
      t.integer :Year
      t.integer :Month
      t.float :Temperature
      t.float :Daylight
      t.integer :EnergyProduction

      t.timestamps
    end
  end
end
