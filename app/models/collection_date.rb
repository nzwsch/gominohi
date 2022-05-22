class CollectionDate < ApplicationRecord
  belongs_to :collection_area
  belongs_to :gomi_type

  validates_presence_of :date
  validates_presence_of :weekday

  scope :with_gomi_type, -> { joins(:gomi_type).select('*, gomi_types.name as gomi_type_name') }

  # presentation
  def display_item
    "#{date.strftime('%Y年%-m月%-d日')}(#{weekday})"
  end
end
