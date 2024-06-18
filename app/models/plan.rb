class Plan < ApplicationRecord
  belongs_to :user
  has_many :izakaya_plans
  has_many :izakayas, through: :izakaya_plans
end
