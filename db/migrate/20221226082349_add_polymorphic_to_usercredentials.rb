class AddPolymorphicToUsercredentials < ActiveRecord::Migration[6.1]
  def change

    change_table :user_credentials do |t|
      t.references :user, polymorphic: true

    end
    
  end
end
