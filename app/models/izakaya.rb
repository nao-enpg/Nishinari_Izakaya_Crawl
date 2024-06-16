class Izakaya < ApplicationRecord
  has_many :izakaya_tags
  has_many :tags, through: :izakaya_tags
end
