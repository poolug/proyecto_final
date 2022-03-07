class AddUserToHousing < ActiveRecord::Migration[5.2]
  def change
    add_reference :housings, :user, foreign_key: true
  end
end
