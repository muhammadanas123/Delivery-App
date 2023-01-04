class CreateJourneys < ActiveRecord::Migration[6.1]
  def change
    create_table :journeys do |t|
      t.string :from
      t.string :to
      t.text :departure_date
      t.text :arrival_date
      t.integer :capacity
      t.integer :rate
      t.references :traveller, null: false, foreign_key: true
      t.timestamps
    end
  end
end
