class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  validates :wallet, numericality: { greater_than_or_equal_to: 0 }

  has_many :stocks
  has_many :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: self
end
