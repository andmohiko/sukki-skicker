class SkickerUser < ApplicationRecord
  belongs_to :skicker
  belongs_to :user

  validates :user_id, :uniqueness => {:scope => :skicker_id}
end
