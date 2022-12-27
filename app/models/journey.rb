class Journey < ApplicationRecord
  belongs_to :traveller

  # enum status: { completed: 0, not_completed: 1 }, _default: "not_completed"

end
