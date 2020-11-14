require 'rails_helper'

RSpec.describe Sukipi, type: :model do
  context "validation tests" do
    it 'ensures name presence' do
      @sukipi = build(:sukipi, name: '')
      expect(@sukipi.valid?).to eq(false)
    end

    it 'ensures suki presence' do
      @sukipi = build(:sukipi, suki: nil)
      expect(@sukipi.valid?).to eq(false)
    end

    it 'ensures user_id presence' do
      @sukipi = build(:sukipi, user_id: nil)
      expect(@sukipi.valid?).to eq(false)
    end

    it 'should save successfully' do
      @sukipi = FactoryBot.create(:sukipi)
      expect(@sukipi).to be_truthy
    end
  end
end
