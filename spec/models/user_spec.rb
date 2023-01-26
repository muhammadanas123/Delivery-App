require 'rails_helper'

RSpec.describe User, type: :model do
  context "when creating a user" do
    let(:user) { build :user }

    it "should be valid user with all attributes" do
      expect(user.valid?).to eq(true)
    end

    it "should validates the firstname" do
      user.firstname = "al"
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq("Firstname is too short (minimum is 3 characters)")  
    end

    it "should validates the firstname" do
      user.lastname = "al"
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq("Lastname is too short (minimum is 3 characters)")  
    end


    it "should validates the phone number and landline" do
      user.phone_no = 11111111
      user.landline = 111111
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq("Phone no is too short (minimum is 11 characters)")
      expect(user.errors.full_messages[1]).to eq("Landline is too short (minimum is 11 characters)")    
    end

    describe "Associations" do
      it { should have_many(:sender_orders) }
      it { should have_many(:traveller_orders) }

    end

  end

  context "when destroying the user" do
    let(:user) { create :user } 
    it "should destroyed the user" do
      user.destroy
      expect(user.destroyed?).to eq(true)
    end
  end

  context "when updating the user" do
    let(:user) { create :user } 
    it "should update the user" do
      params = { firstname: "hassan-updated", 
      lastname: "mazhar-updated", 
      phone_no: 11111111111, 
      landline: 11111111111, 
      city: "lahore", 
      state: "punjab", 
      country: "pakistan" }
      expect(user.update!(params)).to eq(true)
    end
  end

  context "When call the not_completed_journey or completed journeys" do
    let(:user) { create :user }
    let!(:journey) { create :journey, user_id: user.id }
    let!(:journey1) { create :journey, status: "completed", user_id: user.id }   
    it "should return a not completed journey" do
      expect(user.not_completed_journey.status).to eq("not_completed") 
    end

    it "should return a completed journeys" do
      byebug
      expect(user.completed_journeys.present?).to eq(true) 
      user.completed_journeys.each do |journey|
        expect(journey.status).to eq("completed") 
      end
    end
  end
end
