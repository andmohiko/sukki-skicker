require 'rails_helper'

RSpec.describe SkickerUser, type: :model do
  it 'ensures user_id presence' do
    @skicker_user = build(:skicker_user, user_id: nil)
    expect(@skicker_user.valid?).to eq(false)
  end

  it 'ensures skicker_id presence' do
    @skicker_user = build(:skicker_user, skicker_id: nil)
    expect(@skicker_user.valid?).to eq(false)
  end

  it 'should save successfully' do
    @skicker_user = FactoryBot.create(:skicker_user)
    expect(@skicker_user).to be_truthy
  end
end
