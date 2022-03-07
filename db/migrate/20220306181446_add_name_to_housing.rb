class AddNameToHousing < ActiveRecord::Migration[5.2]
  def change
    add_column :housings, :name, :string
  end
end
