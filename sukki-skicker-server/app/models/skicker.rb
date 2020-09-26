class Skicker < ApplicationRecord
  validates :name, presence: true
  validates :power, presence: true
  validates :cost, presence: true
end
