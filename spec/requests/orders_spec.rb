require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "Create Sender" do
    let(:traveller) { create :user }    
    let(:sender) { create :user, email: "bilal@example.com" }    
    before(:each) do
      sign_in(sender)
      get root_path
      sender.add_role :sender
    end

    it "should render the new order form and save it in the db" do
      get new_order_path
      expect(response).to render_template("orders/new")
      expect(response).to have_http_status(200)
      post orders_path, params: {
        order: {
          receiver_name: "aakif", 
          receiver_phone: "11111111111", 
          receiver_address: "dubai, UAE.",
          items_attributes: [itemname: "phone", _destroy: "false"]}
      }
      expect(Order.count).to eq(1)
      expect(Item.count).to eq(1)
      expect(assigns[:order].traveller_id).to eq(traveller.id)
      expect(assigns[:order].sender_id).to eq(sender.id)
      expect(Item.first.itemname).to eq("phone")
      get orders_path
      expect(response).to render_template("orders/index")
      expect(response).to have_http_status(200)
    end

    it "does not create order due to problem in params" do
      get new_order_path
      expect(response).to render_template("orders/new")
      expect(response).to have_http_status(200)
      post orders_path, params: {
        order: {
          receiver_name: "aakif", 
          # receiver_phone: "11111111111", 
          receiver_address: "dubai, UAE.",
          items_attributes: [itemname: "phone", _destroy: "false"]}
      }
      expect(response).to render_template("orders/new")
      expect(response).to have_http_status(200)
    end
  end

  describe "Update Order" do

    let(:traveller) { create :user }    
    let(:sender) { create :user, email: "bilal@example.com" }    
    let(:order) { create :order, traveller_id: traveller.id, sender_id: sender.id } 
    let(:item) { create :item, order_id: order.id } 
    before(:each) do
      sign_in(sender)
      get root_path
      sender.add_role :sender
    end

    it "should render the edit order form and update it in the db" do
      get edit_order_path(order)
      expect(response).to render_template("orders/edit")
      expect(response).to have_http_status(200)
      patch order_path(order), params: {
            order: {
              receiver_name: "aakif-updated", 
              receiver_phone: "11111111111", 
              receiver_address: "dubai, UAE-updated",
              items_attributes: [itemname: "phone-updated", _destroy: "false"]}
          }
      expect(assigns[:order].receiver_name).to eq("aakif-updated") 
      expect(assigns[:order].receiver_phone).to eq(11111111111)
      expect(assigns[:order].receiver_address).to eq("dubai, UAE-updated")  
      expect(Item.first.itemname).to eq("phone-updated")  
      get orders_path
      expect(response).to render_template("orders/index")
      expect(response).to have_http_status(200)    
    end

    it "does not update order due to problem in params" do
      get edit_order_path(order)
      expect(response).to render_template("orders/edit")
      expect(response).to have_http_status(200)
      patch order_path(order), params: {
            order: {
              receiver_name: "aakif-updated", 
              receiver_phone: "", 
              receiver_address: "dubai, UAE-updated",
              items_attributes: [itemname: "phone-updated", _destroy: "false"]}
          }
      expect(response).to render_template("orders/edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "when destroy an sender" do

    let(:traveller) { create :user }    
    let(:sender) { create :user, email: "bilal@example.com" }  
    let(:order) { create :order, traveller_id: traveller.id, sender_id: sender.id } 
    let(:item) { create :item, order_id: order.id } 
    before(:each) do
      sign_in(sender)
      get root_path
      sender.add_role :sender
    end

    it "should destroy the current sender and it's credentials" do
      delete order_path(order)
      expect(Order.count).to eq(0)
      get sender_orders_path
      expect(response).to render_template("orders/index")
      expect(response).to have_http_status(200)
    end
  end
end
