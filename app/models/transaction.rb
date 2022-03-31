class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true
  has_many :housings

  enum type_transaction: %i[ Ingreso Gasto Gasto_Compartido ]
  
  validates :description, :mount, :type_transaction, :housing_id, presence: true

  # límites de registros a mostrar por página
  paginates_per 20

  scope :all_tags, -> {where.not(tag_id: nil)}

  ransacker :date_transaction do
    Arel.sql('date(date_transaction)')
  end

end
