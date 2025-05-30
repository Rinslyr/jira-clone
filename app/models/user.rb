class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :tickets, dependent: :destroy

  ROLES = %i[admin member].freeze

  def admin?
    role == "admin"
  end
end