class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :name
      t.string :description
      t.integer :group_id
      t.boolean :reset_option

      t.timestamps null: false
    end
  end
end
