require "test_helper"

class EmailNotificationServiceTest < ActiveSupport::TestCase
  setup do
    @service = EmailNotificationService.new
  end

  test "#send_notification should return an ActionMailer object" do
    task = Task.first
    assert_equal ActionMailer::MailDeliveryJob, @service.send_notification(task).class
  end

  test "#send_notification should raise an error when argument does not respond to #user" do
    assert_raises(NoMethodError, match: "undefined method `user'") do
      @service.send_notification(:dummy)
    end
  end
end
