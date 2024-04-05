class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :traders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
