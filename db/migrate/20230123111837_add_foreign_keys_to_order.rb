class AddForeignKeysToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :traveller_id, :integer, foreign_key:true 
    add_column :orders, :sender_id, :integer, foreign_key:true
  end
end
