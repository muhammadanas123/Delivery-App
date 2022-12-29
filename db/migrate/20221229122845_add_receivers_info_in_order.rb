class AddReceiversInfoInOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :receiver_name, :string
    add_column :orders, :receiver_phone, :integer
    add_column :orders, :receiver_address, :text
  end
end
