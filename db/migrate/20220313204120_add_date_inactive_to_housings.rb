class AddDateInactiveToHousings < ActiveRecord::Migration[5.2]
  def change
    add_column :housings, :inactive_at, :date
    change_column :housings, :inactive_at, :datetime
  end
end
