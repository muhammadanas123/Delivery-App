class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :itemname
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
