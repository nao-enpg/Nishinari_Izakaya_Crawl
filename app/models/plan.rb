class Plan < ApplicationRecord
  belongs_to :user
  has_many :izakaya_plans, dependent: :destroy
  has_many :izakayas, through: :izakaya_plans
end
