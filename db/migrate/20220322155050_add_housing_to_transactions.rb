class AddHousingToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :housing, foreign_key: true
  end
end
