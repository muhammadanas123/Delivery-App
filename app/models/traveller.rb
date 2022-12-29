class Traveller < ApplicationRecord
    has_one :user_credential
    has_many :journeys
    has_many :orders

end
