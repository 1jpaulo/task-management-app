require "test_helper"

class OverdueNotificationMailerTest < ActionMailer::TestCase
  test "should deliver correct overdue notification email" do
    user = users(:one)
    OverdueNotificationMailer.notify(user, user.tasks.first).deliver_now

    email = ActionMailer::Base.deliveries.first
    assert_equal "fromotherplace@example.com", email.from.first
    assert_equal "Overdue Task: \"#{user.tasks.first.title}\"", email.subject
    assert_equal user.email, email.to.first
    assert_match user.username, email.body.to_s
    assert_match user.tasks.first.title, email.body.to_s
  end
end
