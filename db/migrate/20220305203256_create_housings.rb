class CreateHousings < ActiveRecord::Migration[5.2]
  def change
    create_table :housings do |t|

      t.timestamps
    end
  end
end
