class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_many :plans
  has_many :izakaya_plans, through: :plans
  has_many :favorites, dependent: :destroy
  has_many :favorite_izakayas, through: :favorites, source: :izakaya

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def own?(object)
    object&.user_id == id
  end

  def favorite(izakaya)
    favorite_izakayas << izakaya
  end

  def unfavorite(izakaya)
    favorite_izakayas.delete(izakaya)
  end

  def favorite?(izakaya)
    izakaya.favorites.pluck(:user_id).include?(id)
  end
end
