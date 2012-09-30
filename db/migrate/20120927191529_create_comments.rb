class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :recurrence
      t.references :user
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :comments, :recurrence_id
    add_index :comments, :user_id
  end
end
