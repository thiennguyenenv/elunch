class AddFirstNameLastNameFloorIdWhatYourTasteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :floor_id, :integer
    add_column :users, :what_your_taste, :string
  end
end
