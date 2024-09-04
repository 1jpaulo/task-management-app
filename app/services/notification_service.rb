class NotificationService
  def send_notification(task)
    raise NotImplementedError, "This method should be overridden by subclasses"
  end
end
