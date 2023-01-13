require 'rails_helper'

RSpec.describe "Journeys", type: :request do
  describe "Create Journey" do
    let(:user_credential) { create :user_credential }
    let(:traveller) { create :traveller }  
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = traveller
      user_credential.save
    end

    it "should render the new journey form and save it in the db" do
      get new_traveller_journey_path(traveller)
      expect(response).to render_template("journeys/new")
      expect(response).to have_http_status(200)
      post traveller_journeys_path(traveller), params: {
        journey: {
          from: "lahore", 
          to: "islamabad", 
          departure_date: "20-12-2022", 
          arrival_date: "21-12-2022", 
          capacity: 26, 
          rate: 222, 
        }
      }
      expect(Journey.count).to eq(1)
      expect(response).to redirect_to(traveller_journeys_path(traveller))
      follow_redirect!
    end
  end

  describe "Update Journey" do
    let(:user_credential) { create :user_credential }
    let(:traveller) { create :traveller } 
    let(:journey) { create :journey, traveller_id: traveller.id } 
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = traveller
      user_credential.save
    end

    it "should render the edit journey form and update it in the db when 'from' and 'to' provided" do
      get edit_traveller_journey_path(traveller,journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch traveller_journey_path(traveller,journey), params: {
        journey: {
          from: "lahore-edited", 
          to: "islamabad-edited", 
          departure_date: "21-12-2022",
          arrival_date: "22-12-2022",
          capacity: 22,
          rate: 222 

        }
      }
      expect(assigns[:journey].from).to eq("lahore-edited") 
      expect(assigns[:journey].to).to eq("islamabad-edited") 
      expect(assigns[:journey].departure_date).to eq("21-12-2022") 
      expect(assigns[:journey].arrival_date).to eq("22-12-2022") 
      expect(assigns[:journey].capacity).to eq(22) 
      expect(assigns[:journey].rate).to eq(222)  
      expect(response).to redirect_to(traveller_journey_path(traveller,journey))
      follow_redirect!
    end

    it "should render the edit journey form and update it in the db when 'from' not provided" do
      get edit_traveller_journey_path(traveller,journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch traveller_journey_path(traveller,journey), params: {
        journey: {
          to: "islamabad-edited",
          departure_date: "21-12-2022",
          arrival_date: "22-12-2022",
          capacity: 22,
          rate: 222  

        }
      }
      expect(assigns[:journey].from).to eq(journey.from) 
      expect(assigns[:journey].to).to eq("islamabad-edited") 
      expect(assigns[:journey].departure_date).to eq("21-12-2022") 
      expect(assigns[:journey].arrival_date).to eq("22-12-2022") 
      expect(assigns[:journey].capacity).to eq(22) 
      expect(assigns[:journey].rate).to eq(222)  
      expect(response).to redirect_to(traveller_journey_path(traveller,journey))
      follow_redirect!
    end

    it "should render the edit journey form and update it in the db when 'to' not provided" do
      get edit_traveller_journey_path(traveller,journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch traveller_journey_path(traveller,journey), params: {
        journey: {
          from: "lahore-edited",
          departure_date: "21-12-2022",
          arrival_date: "22-12-2022",
          capacity: 22,
          rate: 222  

        }
      }
      expect(assigns[:journey].from).to eq("lahore-edited") 
      expect(assigns[:journey].to).to eq(journey.to)
      expect(assigns[:journey].departure_date).to eq("21-12-2022") 
      expect(assigns[:journey].arrival_date).to eq("22-12-2022") 
      expect(assigns[:journey].capacity).to eq(22) 
      expect(assigns[:journey].rate).to eq(222)  
      expect(response).to redirect_to(traveller_journey_path(traveller,journey))
      follow_redirect!
    end

    it "should render the edit journey form and update it in the db when not 'from' nor 'to' provided" do
      get edit_traveller_journey_path(traveller,journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch traveller_journey_path(traveller,journey), params: {
        journey: {
          departure_date: "21-12-2022",
          arrival_date: "22-12-2022",
          capacity: 22,
          rate: 222 
        }
      }
      expect(assigns[:journey].from).to eq(journey.from) 
      expect(assigns[:journey].to).to eq(journey.to) 
      expect(assigns[:journey].departure_date).to eq("21-12-2022") 
      expect(assigns[:journey].arrival_date).to eq("22-12-2022") 
      expect(assigns[:journey].capacity).to eq(22) 
      expect(assigns[:journey].rate).to eq(222) 
      expect(response).to redirect_to(traveller_journey_path(traveller,journey))
      follow_redirect!
    end

  end

  describe "when destroying the journey" do
    let!(:user_credential) { create :user_credential }
    let!(:traveller) { create :traveller } 
    let!(:journey) { create :journey, traveller_id: traveller.id } 
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = traveller
      user_credential.save
    end

    it "should destroy the journey" do
      delete traveller_journey_path(traveller,journey)
      expect(Journey.count).to eq(0)
      expect(response).to redirect_to(traveller_journeys_path(traveller))
      follow_redirect!  
    end
  end
end
