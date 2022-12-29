class Sender < ApplicationRecord
    has_one :user_credential
    has_many :orders, dependent: :destroy

end
