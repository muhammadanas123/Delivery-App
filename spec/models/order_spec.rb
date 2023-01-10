require 'rails_helper'

RSpec.describe Order, type: :model do
  context "when creating an order" do
    let(:traveller) { create :traveller }
    let(:sender) { create :sender }

    subject {
      Order.new(traveller_id: traveller.id, sender_id: sender.id, receiver_name: "ali", receiver_phone: 44444444444, receiver_address: "khayaban e amin, lahore")
    }

    it "should be valid with all attributes" do
      expect(subject.valid?).to eq(true)
    end

    it "validates receiver_phone" do
      subject.receiver_phone = 44444444444
      expect(subject.valid?).to eq(true)
    end

    it "validates receiver_address" do
      subject.receiver_address = "khayaban e amin, lahore"
      expect(subject.valid?).to eq(true)
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

    subject {
      Order.new(traveller_id: traveller.id, sender_id: sender.id, receiver_name: "ali", receiver_phone: 44444444444, receiver_address: "khayaban e amin, lahore")
    }
    it "should update the order" do
      params = { traveller_id: traveller.id, 
                  sender_id: sender.id, 
                  receiver_name: "ali-updated", 
                  receiver_phone: 55555555555, 
                  receiver_address: "khayaban e amin, lahore-updated" }
      expect(subject.update!(params)).to eq(true)
    end
  end
end
