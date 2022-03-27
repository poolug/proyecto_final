class AddTagToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :tag, foreign_key: true
  end
end
