class Journey < ApplicationRecord
  belongs_to :traveller
  
  validates :from, :to, :departure_date, :arrival_date, :capacity, :rate, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 40,  only_integer: true }
  enum status: { not_completed: 0, completed: 1 }, _default: "not_completed"
  private
  def self.search(from,to,capacity)
    Journey.where(from: from.downcase, to: to.downcase).where("capacity > ?",capacity.to_i)
  end

  def self.completed_journies(traveller_id)
    Journey.where(traveller_id: traveller_id, status: "completed")
  end

  def self.not_completed_journey_id
    byebug
  end
end
