class CreateTransactionsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions_tags do |t|

      t.timestamps
    end
  end
end
