class Izakaya < ApplicationRecord
  has_many :izakaya_tags
  has_many :tags, through: :izakaya_tags
  has_many :izakaya_plans
  has_many :plans, through: :izakaya_plans
end
