class Tag < ApplicationRecord
  has_many :izakaya_tags
  has_many :izakayas, through: :izakaya_tags
end
