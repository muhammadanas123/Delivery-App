require 'rails_helper'

RSpec.describe "Travellers", type: :request do
  describe "Create Traveller" do
    let(:user_credential) { create :user_credential } 
    before(:each) do
      sign_in(user_credential)
    end

    it "should render the new traveller form and save it in the db" do
      get new_traveller_path
      expect(response).to render_template("travellers/new")
      expect(response).to have_http_status(200)
      post travellers_path, params: {
        traveller: {
          firstname: "anas", 
          lastname: "mazhar", 
          phone_no: 11111111111, 
          landline: 11111111111, 
          city: "lahore", 
          state: "punjab", 
          country: "pakistan"
        }
      }
      expect(Traveller.count).to eq(1)
      expect(UserCredential.first.user).to eq(Traveller.first)   
      expect(response).to redirect_to(Traveller.first)
      follow_redirect!
    end

    it "does not create traveller due to problem in params" do
      get new_traveller_path
      expect(response).to render_template("travellers/new")
      expect(response).to have_http_status(200)
      post travellers_path, params: {
        traveller: {
          firstname: "anas", 
          lastname: "mazhar", 
          # phone_no: 11111111111, 
          landline: 11111111111, 
          city: "lahore", 
          state: "punjab", 
          country: "pakistan"
        }
      }
      expect(response).to render_template("travellers/new")
      expect(response).to have_http_status(200)
    end
  end

  describe "Update Traveller" do
    let(:user_credential) { create :user_credential }
    let(:traveller) { create :traveller }  
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = traveller
      user_credential.save
    end

    it "should render the edit traveller form and update it in the db" do
      get edit_traveller_path(traveller)
      expect(response).to render_template("travellers/edit")
      expect(response).to have_http_status(200)
      patch traveller_path(traveller), params: {
        traveller: {
          firstname: "anas-updated", 
          lastname: "mazhar-updated", 

        }
      }
      get traveller_path(assigns[:traveller])
      expect(response).to have_http_status(200)
      expect(assigns[:traveller].firstname).to eq("anas-updated") 
      expect(assigns[:traveller].lastname).to eq("mazhar-updated") 
    end


    it "does not update traveller due to problem in params" do
      get edit_traveller_path(traveller)
      expect(response).to render_template("travellers/edit")
      expect(response).to have_http_status(200)
      patch traveller_path(traveller), params: {
        traveller: {
          firstname: "anas-updated", 
          lastname: "", 
        }
      }
      expect(response).to render_template("travellers/edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "when accessing the traveller orders or try to destroy traveller" do
    let(:user_credential) { create :user_credential }
    let(:traveller) { create :traveller }  
    let(:sender) { create :sender }
    let(:order) { create :order, traveller_id: traveller.id, sender_id: sender.id }  
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = traveller
      user_credential.save
    end

    it "should show the current traveller's orders" do
      get traveller_orders_path(traveller)
      expect(response).to have_http_status(200)  
    end

    it "should destroy the current traveller and it's credentials" do
      delete traveller_path(traveller)
      expect(Traveller.count).to eq(0)
      expect(UserCredential.count).to eq(0)
      expect(response).to redirect_to(new_user_credential_session_path)
      follow_redirect!  
    end
  end
end
  