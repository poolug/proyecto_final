class AddHousingToHousingUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :housing_users, :housing, foreign_key: true
  end
end
