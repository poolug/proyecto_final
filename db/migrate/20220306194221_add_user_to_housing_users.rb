class AddUserToHousingUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :housing_users, :user, foreign_key: true
  end
end
