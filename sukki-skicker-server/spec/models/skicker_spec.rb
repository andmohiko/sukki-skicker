require 'rails_helper'

RSpec.describe Skicker, type: :model do
  context "validation tests" do
    it 'ensures name presence' do
      @skicker = build(:skicker, name: '')
      expect(@skicker.valid?).to eq(false)
    end

    it 'ensures power presence' do
      @skicker = build(:skicker, power: nil)
      expect(@skicker.valid?).to eq(false)
    end

    it 'ensures cost presence' do
      @skicker = build(:skicker, cost: nil)
      expect(@skicker.valid?).to eq(false)
    end

    it 'should save successfully' do
      @skicker = build(:skicker)
      expect(@skicker.valid?).to eq(true)
    end
  end
end
