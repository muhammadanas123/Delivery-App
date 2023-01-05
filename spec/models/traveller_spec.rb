require 'rails_helper'

RSpec.describe Traveller, type: :model do
  context "when creating a traveller" do
    let(:traveller) { build :traveller }
    it "should be valid traveller with all attributes" do
      byebug
      expect(traveller.valid?).to eq(true)
    end

  end
  
end
