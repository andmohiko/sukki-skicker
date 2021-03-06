class User < ApplicationRecord
  validates :username, presence: true
  validates :uid, presence: true

  has_many :sukipis, dependent: :destroy
  has_many :skicker_users, dependent: :destroy
  has_many :skickers, through: :skicker_users

  def sukipis
    Sukipi.where(user_id: id).order(updated_at: :desc)
  end

end
