class GomiType < ApplicationRecord
  validates_presence_of :kind
  validates_presence_of :name
end
