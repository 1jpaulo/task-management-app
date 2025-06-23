class Card < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, unless: :text?
  validates :text, presence: true, unless: :title?
end
