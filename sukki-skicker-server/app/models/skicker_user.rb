class SkickerUser < ApplicationRecord
  belongs_to :skicker
  belongs_to :user
end
