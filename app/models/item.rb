class Item < ApplicationRecord
  belongs_to :order

  validates :itemname, presence: true

  
end
