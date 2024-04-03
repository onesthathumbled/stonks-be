class Trader < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :confirmable, 
         :recoverable, :rememberable, :validatable
end
