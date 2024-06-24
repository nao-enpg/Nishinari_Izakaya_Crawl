class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :izakaya

  validates :user_id, uniqueness: { scope: :izakaya_id }
end
