class NotificationMailer < ActionMailer::Base
  helper :application
  default from: "noreply@pegasus.cs.virginia.edu"
  def appointment_digest(user)
  	@user = user
  	@appointments = Appointment.where('date = ?', Date.today)
    mail(to: user.email, subject: 'Today\'s Innisfree Appointments')
  end

end
