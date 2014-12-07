scheduler = Rufus::Scheduler.start_new

scheduler.cron("0 6 * * *") do
   # email all the admins a full schedule for the day
   admins = User.where(admin: true)
   admins.each do |admin|
      NotificationMailer.appointment_digest(admin).deliver
   end
   # email all volunteers a reminder
   todays_appointments = Appointment.where('date = ?', Date.today)
   todays_appointments.each do |appointment|
   	  if !appointment.user.nil?
         NotificationMailer.appointment_reminder(appointment).deliver
      end
   end
end