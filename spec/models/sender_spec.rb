require 'rails_helper'

RSpec.describe Sender, type: :model do
  context "when creating a sender" do
    let(:sender) { build :sender }

    it "should be valid sender with all attributes" do
      expect(sender.valid?).to eq(true)
    end

    it "should validates the firstname" do
      sender.firstname = "al"
      expect(sender).to_not be_valid
      expect(sender.errors.full_messages[0]).to eq("Firstname is too short (minimum is 3 characters)")  
    end

    it "should validates the firstname" do
      sender.lastname = "al"
      expect(sender).to_not be_valid
      expect(sender.errors.full_messages[0]).to eq("Lastname is too short (minimum is 3 characters)")  
    end


    it "should validates the phone number and landline" do
      sender.phone_no = 11111111
      sender.landline = 111111
      expect(sender).to_not be_valid
      expect(sender.errors.full_messages[0]).to eq("Phone no is too short (minimum is 11 characters)")
      expect(sender.errors.full_messages[1]).to eq("Landline is too short (minimum is 11 characters)")    
    end

    describe "Associations" do
      it { should have_many(:orders).without_validating_presence }
    end

  end

  context "when destroying the sender" do
    let(:sender) { create :sender } 
    it "should destroyed the sender" do
      sender.destroy
      expect(sender.destroyed?).to eq(true)
    end
  end

  context "when updating the sender" do
    let(:sender) { create :sender } 
    it "should update the sender" do
      params = { firstname: "hassan-updated", 
      lastname: "mazhar-updated", 
      phone_no: 11111111111, 
      landline: 11111111111, 
      city: "lahore", 
      state: "punjab", 
      country: "pakistan" }
      expect(sender.update!(params)).to eq(true)
    end
  end
end
