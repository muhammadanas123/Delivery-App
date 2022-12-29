class Journey < ApplicationRecord
  belongs_to :traveller

  # enum status: { completed: 0, not_completed: 1 }, _default: "not_completed"

  private

  def self.search(from,to,capacity)
    Journey.where(from: from.capitalize, to: to.capitalize).where("capacity > ?",capacity.to_i)
  end

end
