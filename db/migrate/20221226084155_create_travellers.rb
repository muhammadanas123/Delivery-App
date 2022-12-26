class CreateTravellers < ActiveRecord::Migration[6.1]
  def change
    create_table :travellers do |t|
      t.string :firstname
      t.string :lastname
      t.integer :phone_no

      t.timestamps
    end
  end
end
