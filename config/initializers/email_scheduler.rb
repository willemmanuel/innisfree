scheduler = Rufus::Scheduler.start_new

scheduler.every("1m") do
   u = User.where(email: "wre9fz@virginia.edu").first
   NotificationMailer.test_email(u).deliver
   puts "-=-=-= sent email -=-=-=-"
end	