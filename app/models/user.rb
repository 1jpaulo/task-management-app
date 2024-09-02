class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  # No registration page in this application, but this validations would apply for console operations as well.
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create }
  validates :username, uniqueness: true, presence: true

  before_create :normalize_email

  private

  def normalize_email
    self.email.downcase!
  end
end
