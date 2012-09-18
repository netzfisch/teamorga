class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :category
      t.date :base_date
      t.time :base_time
      t.date :end_date
      t.string :place
      t.text :remark

      t.timestamps
    end
  end
end
