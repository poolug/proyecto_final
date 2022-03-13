class AddDateInactiveToHousings < ActiveRecord::Migration[5.2]
  def change
    add_column :housings, :inactive_at, :date
  end
end
