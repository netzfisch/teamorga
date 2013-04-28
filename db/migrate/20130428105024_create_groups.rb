class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :logo_url
      t.text :public_information
      t.text :private_information

      t.timestamps
    end
  end
end
