require 'rails_helper'

RSpec.describe Traveller, type: :model do
  context "when creating a traveller" do
    let(:traveller) { build :traveller }

    it "should be valid traveller with all attributes" do
      expect(traveller.valid?).to eq(true)
    end

    it "should validates the firstname" do
      traveller.firstname = "al"
      expect(traveller).to_not be_valid
      expect(traveller.errors.full_messages[0]).to eq("Firstname is too short (minimum is 3 characters)") 
    end

    it "should validates the lastname" do
      traveller.lastname = "al"
      expect(traveller).to_not be_valid
      expect(traveller.errors.full_messages[0]).to eq("Lastname is too short (minimum is 3 characters)") 
    end

    it "should validates the phone number and landline" do
      traveller.phone_no = 11111111
      traveller.landline = 111111
      expect(traveller).to_not be_valid
      expect(traveller.errors.full_messages[0]).to eq("Phone no is too short (minimum is 11 characters)")
      expect(traveller.errors.full_messages[1]).to eq("Landline is too short (minimum is 11 characters)")    
    end

    describe "Associations" do
      it { should have_many(:orders).without_validating_presence }
      it { should have_many(:journeys).without_validating_presence }
    end

    end

    context "when destroying the traveller" do
      let(:traveller) { create :traveller } 
      it "should destroyed the traveller" do
        traveller.destroy
        expect(traveller.destroyed?).to eq(true)
      end
    end

    context "when updating the traveller" do
      let(:traveller) { create :traveller } 
      it "should update the traveller" do
        params = { firstname: "anas-updated", 
        lastname: "mazhar-updated", 
        phone_no: 11111111111, 
        landline: 11111111111, 
        city: "lahore", 
        state: "punjab", 
        country: "pakistan" }
        expect(traveller.update!(params)).to eq(true)
      end
    end
end
