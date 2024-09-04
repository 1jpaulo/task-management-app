require "test_helper"

class NotificationServiceTest < ActiveSupport::TestCase
  setup do
    @service = NotificationService.new
  end

  test "#send_notification should raise error when no argument is given" do
    assert_raises(ArgumentError) { @service.send_notification }
  end

  test "#send_notification should raise error" do
    assert_raises(NotImplementedError, match: "This method should be overridden by subclasses") do
      @service.send_notification(:dummy)
    end
  end
end
