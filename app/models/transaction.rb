class Transaction < ApplicationRecord
  belongs_to :user

  validates :description, :mount, :type_transaction, presence: true

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
end
