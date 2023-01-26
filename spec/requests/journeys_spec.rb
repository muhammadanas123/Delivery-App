require 'rails_helper'

RSpec.describe "Journeys", type: :request do
  describe "Create Journey" do
    let(:user) { create :user }
    before(:each) do
      sign_in(user)
      get root_path
      user.add_role :traveller
    end

    it "should render the new journey form and save it in the db" do
      get new_journey_path
      expect(response).to render_template("journeys/new")
      expect(response).to have_http_status(200)
      post journeys_path, params: {
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
      get journeys_path
      expect(response).to render_template("journeys/index")
      expect(response).to have_http_status(200)      
    end
  end

  describe "Update Journey" do
    let(:user) { create :user }
    let(:journey) { create :journey, user_id: user.id } 
    before(:each) do
      sign_in(user)
      get root_path
      user.add_role :traveller
    end

    it "should render the edit journey form and update it in the db when 'from' and 'to' provided" do
      get edit_journey_path(journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch journey_path(journey), params: {
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
      get journey_path(journey)
      expect(response).to render_template("journeys/show")
      expect(response).to have_http_status(200)  
    end

    it "should render the edit journey form and update it in the db when 'from' not provided" do
      get edit_journey_path(journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch journey_path(journey), params: {
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
      get journey_path(journey)
      expect(response).to render_template("journeys/show")
      expect(response).to have_http_status(200)  
    end

    it "should render the edit journey form and update it in the db when 'to' not provided" do
      get edit_journey_path(journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch journey_path(journey), params: {
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
      get journey_path(journey)
      expect(response).to render_template("journeys/show")
      expect(response).to have_http_status(200)  
    end

    it "should render the edit journey form and update it in the db when not 'from' nor 'to' provided" do
      get edit_journey_path(journey)
      expect(response).to render_template("journeys/edit")
      expect(response).to have_http_status(200)
      patch journey_path(journey), params: {
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
      get journey_path(journey)
      expect(response).to render_template("journeys/show")
      expect(response).to have_http_status(200)  
    end

  end

  describe "when destroying the journey" do
    let!(:user) { create :user }
    let!(:journey) { create :journey, user_id: user.id } 
    before(:each) do
      sign_in(user)
      get root_path
      user.add_role :traveller
    end

    it "should destroy the journey" do
      delete journey_path(journey)
      expect(Journey.count).to eq(0)
      get journeys_path
      expect(response).to render_template("journeys/index")
      expect(response).to have_http_status(200)     
    end
  end
end
