require 'rails_helper'

RSpec.describe Traveller, type: :model do
  context "when creating a traveller" do
    let(:traveller) { build :traveller }

    it "should be valid traveller with all attributes" do
      expect(traveller.valid?).to eq(true)
    end

    it "should validates the firstname" do
      traveller = Traveller.new(firstname: "anas")
      expect(traveller).to be_valid
    end

    it "should validates the lastname" do
      traveller = Traveller.new(lastname: "mazhar")
      expect(traveller).to be_valid
    end

    it "should validates the phone number and landline" do
      traveller = Traveller.new(phone_no: 11111111111, landline: 11111111111)
      expect(traveller).to be_valid
    end

    describe "Associations" do
      it { should have_many(:orders).without_validating_presence }
      it { should have_many(:journeys).without_validating_presence }
    end

    end

    context "when destroying the traveller" do
      it "should destroyed the traveller" do
        traveller = Traveller.create(firstname: "anas", 
                                      lastname: "mazhar", 
                                      phone_no: 11111111111, 
                                      landline: 11111111111, 
                                      city: "lahore", 
                                      state: "punjab", 
                                      country: "pakistan")
        traveller.destroy
        expect(traveller.destroyed?).to eq(true)
      end
    end

    context "when updating the traveller" do
      it "should update the traveller" do
        traveller = Traveller.create(firstname: "anas", 
                                      lastname: "mazhar", 
                                      phone_no: 11111111111, 
                                      landline: 11111111111, 
                                      city: "lahore", 
                                      state: "punjab", 
                                      country: "pakistan")
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
