class Order < ApplicationRecord
  belongs_to :traveller
  belongs_to :sender
  has_many :items, inverse_of: :order, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates_associated :items
  validates :receiver_address, length: {minimum:11, maximum:60}, presence: true
  validates :receiver_phone, length: {minimum:11, maximum:11}, presence: true
end
