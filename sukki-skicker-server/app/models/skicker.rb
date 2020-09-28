class Skicker < ApplicationRecord
  validates :name, presence: true
  validates :power, presence: true
  validates :cost, presence: true

  has_many :skicker_users
  has_many :users, through: :skicker_users
end
