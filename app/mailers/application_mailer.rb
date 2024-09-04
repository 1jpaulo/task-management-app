class ApplicationMailer < ActionMailer::Base
  # NOTE: if you want a global wide change, comment this and change in config/environments/$RAILS_ENV.rb
  default from: "fromotherplace@example.com"
  layout "mailer"
end
