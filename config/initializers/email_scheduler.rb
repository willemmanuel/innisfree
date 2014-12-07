scheduler = Rufus::Scheduler.start_new

# Send the digest every day at noon
scheduler.cron("0 6 * * *") do
   u = User.where(email: "wre9fz@virginia.edu").first
   NotificationMailer.appointment_digest(u).deliver
end