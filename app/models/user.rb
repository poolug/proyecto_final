class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :transactions
  has_many :housing_users
  has_many :housings, through: :housing_users, dependent: :destroy

  enum role: %i[ Admin Member ]

  before_create :user_default

  def user_default
    self.role = 0
  end

end
