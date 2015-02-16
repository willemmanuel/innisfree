class NotificationMailer < ActionMailer::Base
  helper :application
  default from: "noreply@pegasus.cs.virginia.edu"
  def appointment_digest(user)
  	@user = user
  	@appointments = Appointment.where('date = ?', Date.today)
    mail(to: user.email, subject: 'Today\'s Innisfree Appointments')
  end

  def appointment_reminder(appointment)
  	@appointment = appointment
  	mail(to: @appointment.user.email, subject: 'Upcoming appointment today')
  end

  def recurring_appointment_reminder(appointment)
  	@appointment = appointment
  	mail(to: @appointment.user.email, subject: 'Schedule Follow-up Appointment')
  end

end
