class User < ApplicationRecord
  has_secure_password

  # TODO: TEST all of it below.
  has_many :tasks, dependent: :destroy

  # No registration page in this application, but this validations would apply for console operations as well.
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create }
  validates :username, uniqueness: true, presence: true
end
