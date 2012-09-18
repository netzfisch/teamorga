class CreateRecurrences < ActiveRecord::Migration
  def change
    create_table :recurrences do |t|
      t.date :scheduled_to
      t.references :event

      t.timestamps
    end
    add_index :recurrences, :event_id
  end
end
