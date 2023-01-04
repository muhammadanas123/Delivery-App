class Traveller < ApplicationRecord
    has_one :user_credential
    has_many :journeys, dependent: :destroy
    has_many :orders

    validates_associated :journeys
    validates :firstname, :lastname, length: { minimum: 3, maximum: 15 }, presence: true
    validates :phone_no, :landline, length: { minimum:11, maximum:11 }
end
