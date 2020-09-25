class Sukki < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :skicker_id, presence: true
end
