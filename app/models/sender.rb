class Sender < ApplicationRecord
    has_one :user_credential, as: :user
    has_many :orders, dependent: :destroy

    validates_associated :orders
    validates :firstname, :lastname, length: { minimum: 3, maximum: 15 }, presence: true
    validates :phone_no, :landline, length: { minimum:11, maximum:11 }
end
