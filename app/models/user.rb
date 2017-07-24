class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :services
end
