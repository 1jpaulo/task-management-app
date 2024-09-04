class OverdueTaskNotificationWorker
  include Sidekiq::Worker

  # NOTE
  # 2 changes would heavily improve:
  # - Send one email per user instead of per task. So if a user has more than one overdue task it will trigger only
  # once
  # - There is no current way to tell which tasks were already notified as overdue, so we would likely need to have a
  # user table column to store this value
  # P.s. Of course that with the first improvement this wouldn't be a huge problem since only one email would be
  # triggered anyway.
  def perform(notification_service_class = "EmailNotificationService")
    notification_service = notification_service_class.constantize.new

    Task.incomplete.overdue.find_each do |task|
      notification_service.send_notification(task)
    end
  end
end
