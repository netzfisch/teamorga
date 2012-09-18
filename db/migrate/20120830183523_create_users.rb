class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :shirt_number
      t.string :email
      t.string :phone
      t.date :birthday
      
      t.timestamps
    end
  end
end
