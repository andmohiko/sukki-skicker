require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it 'ensures username presence' do
      @user = build(:user, username: '')
      expect(@user.valid?).to eq(false)
    end

    it 'ensures uid presence' do
      @user = build(:user, uid: '')
      expect(@user.valid?).to eq(false)
    end

    it 'should save successfully' do
      @user = FactoryBot.create(:user)
      expect(@user).to be_truthy
    end
  end
end
