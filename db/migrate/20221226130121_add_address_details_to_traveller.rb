class AddAddressDetailsToTraveller < ActiveRecord::Migration[6.1]
  def change
    add_column :travellers, :landline, :integer
    add_column :travellers, :city, :string
    add_column :travellers, :state, :string
    add_column :travellers, :country, :string
  end
end
