class House < ApplicationRecord
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      house = find_by(id: row["id"]) || new
      house.attributes = row.to_hash.slice(*updatable_attributes)
      house.save
    end
  end
  def self.updatable_attributes
    ["id", "Firstname", "Lastname", "City", "num_of_people", "has_child"]
  end

  has_many :products, dependent: :destroy

end
