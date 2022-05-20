class GomiType < ApplicationRecord
  has_many :collection_dates

  validates_presence_of :id
  validates_presence_of :name
end
