class Transaction < ApplicationRecord
  belongs_to :user

  has_many :housings

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
  
  validates :description, :mount, :type_transaction, :housing_id, presence: true

end
