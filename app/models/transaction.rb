class Transaction < ApplicationRecord
  belongs_to :user

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
end
