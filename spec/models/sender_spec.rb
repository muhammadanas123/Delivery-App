require 'rails_helper'

RSpec.describe Sender, type: :model do
  context "when creating a sender" do
    let(:sender) { build :sender }

    it "should be valid sender with all attributes" do
      expect(sender.valid?).to eq(true)
    end

    it "should validates the firstname" do
      sender = Sender.new(firstname: "hassan")
      expect(sender).to be_valid
    end

    it "should validates the lastname" do
      sender = Sender.new(lastname: "mazhar")
      expect(sender).to be_valid
    end

    it "should validates the phone number and landline" do
      sender = Sender.new(phone_no: 11111111111, landline: 11111111111)
      expect(sender).to be_valid
    end

    describe "Associations" do
      it { should have_many(:orders).without_validating_presence }
    end

  end

    context "when destroying the sender" do
      it "should destroyed the sender" do
        sender = Sender.create(firstname: "hassan", 
                                lastname: "mazhar", 
                                phone_no: 11111111111, 
                                landline: 11111111111, 
                                city: "lahore", 
                                state: "punjab", 
                                country: "pakistan")
        sender.destroy
        expect(sender.destroyed?).to eq(true)
      end
    end

    context "when updating the sender" do
      it "should update the sender" do
        sender = Sender.create(firstname: "hassan", 
                                lastname: "mazhar", 
                                phone_no: 11111111111, 
                                landline: 11111111111, 
                                city: "lahore", 
                                state: "punjab", 
                                country: "pakistan")
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
