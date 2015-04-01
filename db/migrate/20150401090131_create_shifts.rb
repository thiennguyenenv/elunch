class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.text :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
