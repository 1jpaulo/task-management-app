require "sidekiq-cron"

Sidekiq::Cron::Job.create(
  name: "Overdue Task Email Notification",
  # cron: "0 * * * *", # every hour
  cron: "* * * * *", # every minute
  class: "OverdueTaskNotificationWorker",
  args: ["EmailNotificationService"]
)


# NOTE: other channels will be added here as well, having concerns separated we can
# set different time intervals for each notification channel

# Example of an SMS notification service
# Sidekiq::Cron::Job.create(
#   name: "Overdue Task SMS Notification",
#   cron: "0 * * * *",
#   class: "OverdueTaskNotificationWorker",
#   args: ["SmsNotificationService"]
# )
