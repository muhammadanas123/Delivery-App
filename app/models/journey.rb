class Journey < ApplicationRecord
  resourcify
  belongs_to :user
  
  validates :from, :to, :departure_date, :arrival_date, :capacity, :rate, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 40,  only_integer: true }
  enum status: { not_completed: 0, completed: 1 }, _default: "not_completed"
  private
  def self.search(from,to,capacity)
    where(from: from.downcase, to: to.downcase, status: "not_completed").where("capacity > ?",capacity.to_i)
  end

  def self.completed_journies(traveller_id)
    where(user_id: traveller_id, status: "completed")
  end

  def self.not_completed_journey(traveller_id)
    where(user_id: traveller_id, status: "not_completed")
  end

  def self.not_completed_journey_id(traveller_id)
    journey = where(user_id: traveller_id, status: "not_completed")
    journey[0].id
  end
end
