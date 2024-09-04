class Task < ApplicationRecord
  belongs_to :user

  PRIORITY_LIST = { Low: 1, Medium: 2, High: 3 }.freeze

  validates :title, presence: true
  validates :priority, presence: true, inclusion: { in: PRIORITY_LIST.values }
  validates :due_date, presence: true

  scope :overdue, -> { where("due_date < ?", Time.current) }
  scope :incomplete, -> { where(completed: false) }
end
