require 'rails_helper'

RSpec.describe "Senders", type: :request do
  describe "Create Sender" do
    let(:user_credential) { create :user_credential } 
    before(:each) do
      sign_in(user_credential)
    end

    it "should render the new sender form and save it in the db" do
      get new_sender_path
      expect(response).to render_template("senders/new")
      expect(response).to have_http_status(200)
      post senders_path, params: {
        sender: {
          firstname: "hassan", 
          lastname: "mazhar", 
          phone_no: 11111111111, 
          landline: 11111111111, 
          city: "lahore", 
          state: "punjab", 
          country: "pakistan"
        }
      }
      expect(Sender.count).to eq(1)
      byebug
      expect(UserCredential.first.user).to eq(Sender.first)   
      get sender_path(Sender.first)
      expect(response).to render_template("senders/show")
      expect(response).to have_http_status(200)
    end

    it "does not create sender due to problem in params" do
      get new_sender_path
      expect(response).to render_template("senders/new")
      expect(response).to have_http_status(200)
      post senders_path, params: {
        sender: {
          firstname: "anas", 
          lastname: "mazhar", 
          # phone_no: 11111111111, 
          landline: 11111111111, 
          city: "lahore", 
          state: "punjab", 
          country: "pakistan"
        }
      }
      expect(response).to render_template("senders/new")
      expect(response).to have_http_status(200)
    end
  end

  describe "Update Sender" do
    let(:user_credential) { create :user_credential }
    let(:sender) { create :sender }  
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = sender
      user_credential.save
    end

    it "should render the edit sender form and update it in the db" do
      get edit_sender_path(sender)
      expect(response).to render_template("senders/edit")
      expect(response).to have_http_status(200)
      patch sender_path(sender), params: {
        sender: {
          firstname: "hassan-updated", 
          lastname: "mazhar-updated", 

        }
      }
      expect(assigns[:sender].firstname).to eq("hassan-updated") 
      expect(assigns[:sender].lastname).to eq("mazhar-updated") 
      get sender_path(assigns[:sender])
      expect(response).to have_http_status(200)
    end

    it "does not update sender due to problem in params" do
      get edit_sender_path(sender)
      expect(response).to render_template("senders/edit")
      expect(response).to have_http_status(200)
      patch sender_path(sender), params: {
        sender: {
          firstname: "mazhar-updated", 
          lastname: "", 
        }
      }
      expect(response).to render_template("senders/edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "when accessing the traveller_list or try to destroy sender" do
    let!(:user_credential) { create :user_credential }
    let!(:sender) { create :sender }
    let!(:traveller) { create :traveller } 
    let!(:journey) { create :journey, traveller_id: traveller.id } 
    before(:each) do
      sign_in(user_credential)
      get root_path
      user_credential.user = sender
      user_credential.save
    end

    it "should show the traveller list on the basis of (from,to,capacity)" do
      get traveller_list_path, params: {
        sender: {
          from: "lahore",
          to: "islamabad",
          capacity: 19
        }
      }
      journeys = Journey.search("lahore", "islamabad", 19)
      expect(journeys[0].from).to eq("lahore") 
      expect(journeys[0].to).to eq("islamabad")
      expect(journeys[0].capacity).to be > 19
    end

    it "should destroy the current sender and it's credentials" do
      delete sender_path(sender)
      expect(Sender.count).to eq(0)
      expect(UserCredential.count).to eq(0)
      get new_user_credential_session_path
      expect(response).to have_http_status(200)
    end
  end
end
