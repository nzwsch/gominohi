class CollectionArea < ApplicationRecord
  belongs_to :area
  has_many :collection_dates

  validates_presence_of :name

  class << self
    def create_by_area_name(name)
      area_name = name.sub(/区.$/, "区")
      area = Area.find_by_name(area_name)
      self.create(area: area, name: name)
    end
  end
end
