class AddBasicInfoToSender < ActiveRecord::Migration[6.1]
  def change
    add_column :senders, :landline, :integer
    add_column :senders, :city, :string
    add_column :senders, :state, :string
    add_column :senders, :country, :string
  end
end
