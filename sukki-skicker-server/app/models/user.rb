class User < ApplicationRecord
  has_many :sukipis, dependent: :destroy
  validates :username, presence: true
  validates :uid, presence: true

  def sukipis
    Sukipi.where(user_id: id)
  end
end
