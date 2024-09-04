class OverdueNotificationMailer < ApplicationMailer
  def notify(user, task)
    @user = user
    @task = task
    mail(to: user.email, subject: "Overdue Task: \"#{task.title}\"")
  end
end
