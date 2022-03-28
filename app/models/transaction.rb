class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :housings

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
  
  validates :description, :mount, :type_transaction, :housing_id, presence: true

  # límites de registros a mostrar por página
  paginates_per 20

end
