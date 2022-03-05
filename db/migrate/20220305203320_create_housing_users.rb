class CreateHousingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :housing_users do |t|

      t.timestamps
    end
  end
end
