scheduler = Rufus::Scheduler.start_new

# Send the digest every day at noon
scheduler.cron("0 6 * * *") do
   admins = User.where(admin: true)
   admins.each do |admin|
      NotificationMailer.appointment_digest(admin).deliver
   end
end