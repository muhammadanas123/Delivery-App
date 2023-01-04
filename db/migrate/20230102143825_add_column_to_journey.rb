class AddColumnToJourney < ActiveRecord::Migration[6.1]
  def change
    add_column :journeys, :status, :integer
  end
end
