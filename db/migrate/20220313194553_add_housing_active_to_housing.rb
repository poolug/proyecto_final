class AddHousingActiveToHousing < ActiveRecord::Migration[5.2]
  def change
    add_column :housings, :status, :integer
  end
end
