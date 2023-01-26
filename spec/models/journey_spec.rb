require 'rails_helper'

RSpec.describe Journey, type: :model do
  context "when creating a journey" do
    let(:user) { create :user } 
    let(:journey) { create :journey, user_id: user.id } 
    it "should be valid journey with all attributes" do
      expect(journey.valid?).to eq(true)
    end

    it "should validates 'from'" do
      journey.from = ""
      expect(journey).not_to be_valid
      expect(journey.errors.full_messages[0]).to eq("From can't be blank")  
    end

    it "should validates the to" do
      journey.to = ""
      expect(journey).not_to be_valid 
      expect(journey.errors.full_messages[0]).to eq("To can't be blank")  
    end

    it "should validates the departure date and arrival date" do
      journey.departure_date = ""
      journey.arrival_date = ""
      expect(journey).not_to be_valid 
      expect(journey.errors.full_messages[0]).to eq("Departure date can't be blank") 
      expect(journey.errors.full_messages[1]).to eq("Arrival date can't be blank") 
    end

    it "should validates the rate" do
      journey.rate = ""
      expect(journey).not_to be_valid
      expect(journey.errors.full_messages[0]).to eq("Rate can't be blank") 
    end

    it "should validates the capacity presence" do
      journey.capacity= ""
      expect(journey).not_to be_valid
      expect(journey.errors.full_messages[0]).to eq("Capacity can't be blank") 
    end

    describe "Associations" do
      it { should belong_to(:user) }
    end

  end

  describe ".search" do
    let(:user) { create :user } 
    let!(:journey) { create :journey, user_id: user.id } 
    it "should search on the basis of (from, to and capacity)" do      
      from = "lahore"
      to = "islamabad"
      capacity = 19
      journeys = Journey.search(from,to,capacity)
      expect(journeys.present?).to eq(true) 
      journeys.each do |journey|
        expect(journey.from).to eq("lahore") 
        expect(journey.to).to eq("islamabad")
        expect(journey.capacity).to be > 19
      end
    end
  end
end
