class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :housings, dependent: :destroy

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
  
  validates :description, :mount, :type_transaction, :housing_id, presence: true

end
