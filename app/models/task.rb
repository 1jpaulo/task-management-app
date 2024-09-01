class Task < ApplicationRecord
  belongs_to :user

  PRIORITY_LIST = %w[ low medium high urgent].freeze

  validates :title, presence: true
  validates :priority, presence: true, inclusion: { in: PRIORITY_LIST }
  validates :due_date, presence: true
end
