class Order < ApplicationRecord
  resourcify
  belongs_to :traveller, class_name: "User", foreign_key: "traveller_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  has_many :items, inverse_of: :order, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :receiver_address, length: {minimum:11, maximum:60}, presence: true
  validates :receiver_phone, length: {minimum:11, maximum:11}, presence: true
end
