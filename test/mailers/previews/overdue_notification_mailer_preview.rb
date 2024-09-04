# Preview all emails at http://localhost:3000/rails/mailers/overdue_notification_mailer
class OverdueNotificationMailerPreview < ActionMailer::Preview
  def notify
    OverdueNotificationMailer.notify(User.first, User.first.tasks.first)
  end
end
