class Housing < ApplicationRecord
  has_many :housing_users
  has_many :users, through: :housing_users, dependent: :destroy

  validates :name, presence: :true

  enum status: %i[ Active Inactive ]

  scope :members_on_housing, -> { where(status: "Active").order(created_at: :asc) }

  def set_housing_name
    self.transactions
  end
  
end
