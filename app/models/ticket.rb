class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
  validates :status, inclusion: { in: %w[to_do in_progress done] }
  validates :priority, inclusion: { in: %w[low medium high] }, allow_nil: true

  has_many :comments, dependent: :destroy

  before_validation :set_default_status
  before_validation :set_default_priority

  def status_display
    case status
    when 'to_do' then 'To Do'
    when 'in_progress' then 'In Progress'
    when 'done' then 'Done'
    else status
    end
  end

  private

  def set_default_status
    self.status ||= 'to_do'
  end

  def set_default_priority
    self.priority ||= 'medium'
  end
end
