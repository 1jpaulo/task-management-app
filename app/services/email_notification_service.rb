class EmailNotificationService < NotificationService
  def send_notification(task)
    OverdueNotificationMailer.notify(task.user, task).deliver_later
  end
end
