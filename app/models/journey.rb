class Journey < ApplicationRecord
  belongs_to :traveller

  enum status: { not_completed: 0, completed: 1 }, _default: "not_completed"

  validates :from, :to, :departure_date, :arrival_date, :capacity, :rate, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 40,  only_integer: true }


  private

  def self.search(from,to,capacity)
    Journey.where(from: from.capitalize, to: to.capitalize).where("capacity > ?",capacity.to_i)
  end

end
