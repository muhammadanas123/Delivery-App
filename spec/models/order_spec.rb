require 'rails_helper'

RSpec.describe Order, type: :model do
  context "when creating an order" do
    let(:traveller) { create :traveller }
    let(:sender) { create :sender }
    let(:order) { create :order, sender_id: sender.id, traveller_id: traveller.id } 

    it "should be valid with all attributes" do
      expect(order.valid?).to eq(true)
    end

    it "validates receiver_phone" do
      order.receiver_phone = 444444444
      expect(order).to_not be_valid
      expect(order.errors.full_messages[0]).to eq("Receiver phone is too short (minimum is 11 characters)")  
    end

    it "validates receiver_address" do
      order.receiver_address = "khayaban"
      expect(order).to_not be_valid
      expect(order.errors.full_messages[0]).to eq("Receiver address is too short (minimum is 11 characters)")  
    end
  end

  describe "Associations" do
    it { should belong_to(:traveller) }
    it { should belong_to(:sender) }
    it { should have_many(:items) }
    it { should accept_nested_attributes_for(:items).allow_destroy(true) }
  end

  context "when updating an order" do
    let(:traveller) { create :traveller }
    let(:sender) { create :sender }
    let(:order) { create :order, sender_id: sender.id, traveller_id: traveller.id } 

    it "should update the order" do
      params = { traveller_id: traveller.id, 
                  sender_id: sender.id, 
                  receiver_name: "ali-updated", 
                  receiver_phone: 55555555555, 
                  receiver_address: "khayaban e amin, lahore-updated" }
      expect(order.update!(params)).to eq(true)
    end
  end
end
