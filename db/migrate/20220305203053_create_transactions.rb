class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :mount
      t.date :date_transaction
      t.integer :type_transaction

      t.timestamps
    end
  end
end
