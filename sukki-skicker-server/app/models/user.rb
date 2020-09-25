class User < ApplicationRecord
  validates :username, presence: true
  validates :uid, presence: true

  has_many :skicker, dependent: :destroy

  def skickers
    Skicker.where(user_id: id)
  end
end
