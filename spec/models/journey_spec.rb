require 'rails_helper'

RSpec.describe Journey, type: :model do
  context "when creating a journey" do

    it "should be valid journey with all attributes" do
      traveller = Traveller.create(firstname: "anas", 
                                    lastname: "mazhar", 
                                    phone_no: 11111111111, 
                                    landline: 11111111111, 
                                    city: "lahore", 
                                    state: "punjab", 
                                    country: "pakistan")

      journey = Journey.new( from: "lahore",
                              to: "islamabad",
                              departure_date: "27-11-2022",
                              arrival_date: "28-11-2022",
                              capacity: 20,
                              rate: 333,
                              traveller_id: traveller.id)

      expect(journey.valid?).to eq(true)
    end

    it "should validates the from" do
      journey = Journey.new(from: "lahore")
      expect(journey).to be_valid
    end

    it "should validates the lastname" do
      journey = Journey.new(to: "islamabad")
      expect(journey).to be_valid
    end

    it "should validates the departure date and arrival date" do
      journey = Journey.new(departure_date: "22-10-2022", arrival_date: "23-11-2022")
      expect(journey).to be_valid
    end

    it "should validates the rate" do
      journey = Journey.new(rate: 333)
      expect(journey).to be_valid
    end

    it "should validates the capacity presence and range" do
      journey = Journey.new(capacity: 20)
      expect(journey).to be_valid
    end

    describe "Associations" do
      it { should belong_to(:traveller) }
    end

  end

  describe ".search" do
    it "should search on the basis of (from, to and capacity)" do
      traveller = Traveller.create(firstname: "anas", lastname: "mazhar", phone_no: 11111111111, landline: 11111111111, city: "lahore", state: "punjab", country: "pakistan")
      journey = Journey.create( from: "lahore", to: "islamabad", departure_date: "27-11-2022", arrival_date: "28-11-2022", capacity: 20, rate: 333, traveller_id: traveller.id)
      
      from = "lahore"
      to = "islamabad"
      capacity = 19      
      expect(Journey.search(from,to,capacity).empty?).to eq(false)
    end
  end
end
