class Housing < ApplicationRecord
  has_many :housing_users
  has_many :users, through: :housing_users, dependent: :destroy
  validates :name, presence: :true
  # belongs_to :user
end
