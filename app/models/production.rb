class Production < ApplicationRecord

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      production = find_by(id: row["id"]) || new
      production.attributes = row.to_hash.slice(*updatable_attributes)
      production.save
    end
  end
  def self.updatable_attributes
    ["id", "Label", "House_id", "Year", "Month", "Temperature", "Daylight", "EnergyProduction" ]
  end

  belongs_to :house
end