class Area < ApplicationRecord
  has_many :collection_areas

  validates_presence_of :name
end
