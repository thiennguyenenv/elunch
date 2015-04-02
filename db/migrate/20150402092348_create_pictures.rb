class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :description
      t.integer :meal_id
      t.attachment :image

      t.timestamps null: false
    end
  end
end
