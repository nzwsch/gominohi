class CollectionDate < ApplicationRecord
  belongs_to :collection_area
  belongs_to :gomi_type

  validates_presence_of :date
  validates_presence_of :weekday
end
