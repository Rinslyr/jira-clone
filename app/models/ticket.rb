class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :title, presence: true
  validates :status, inclusion: { in: %w[To\ Do In\ Progress Done] }
end
