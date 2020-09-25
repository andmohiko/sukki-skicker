class User < ApplicationRecord
  validates :username, presence: true
  validates :uid, presence: true

  has_many :skicker, dependent: :destroy
  has_many :sukki, dependent: :destroy

  def skickers
    Skicker.where(user_id: id)
  end

  def sukkis
    Sukki.where(user_id: id)
  end
end
