class NotificationMailer < ActionMailer::Base
  helper :application
  default :from => 'noreply <noreply@innisfreevillage.org>'

  # Parameter: user to send email to
  # appointment_digest - sends a digest of the day's appointments to the specified user 
  def appointment_digest(user)
  	@user = user
  	@appointments = Appointment.where('date = ?', Date.today)
    mail(to: user.email, subject: 'Today\'s Innisfree Appointments')
  end
  
  # Parameter: user to send email to
  # weekly_digest - sends a digest of the next week's appointments to the specified user 
  def weekly_digest(user)
    @user = user
    @appointments = Appointment.where('date >= ?', Date.tomorrow).where('date <= ?', Date.tomorrow+7)
    mail(to: user.email, subject: 'This week\'s Innisfree Appointments')
  end

  # Parameter: appointment to send a reminder about
  # appointment_reminder - sends a reminder to the assigned volunteer about the specified appointment
  def appointment_reminder(appointment)
  	@appointment = appointment
  	mail(to: @appointment.user.email, subject: 'Upcoming appointment today')
  end

  # Parameter: appointment to send a reminder about
  # appointment_assignment-reminder - sends an email to the appointment's volunteer that they have been assigned to an appointment
  def appointment_assignment_notification(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Appointment Assignment Notification')
  end  

  # Parameter: appointment to send a reminder about
  # recurring_appointment_reminder - sends a reminder to schedule a follow up appointment to the given appointment
  def recurring_appointment_reminder(appointment)
  	@appointment = appointment
    user = User.where('id = ?', @appointment.user_id)[0];
  	mail(to: user.email, subject: 'Schedule Follow-up Appointment')
  end

  # Parameter: appointment to send a reminder about
  # Parameter: user to send a reminder to
  # new_appointment_notification - sends an email notifying the given user they have been assigned an appointment
  def new_appointment_notification(appointment, user)
    @appointment = appointment
    @user = user
    mail(to: @user.email, subject: 'New Appointment Scheduled')
  end

  # Parameter: appointment to send a reminder about
  # Parameter: user to send a reminder to
  # house_reminder - sends an email to the house to remind them of an appointment
  def house_reminder(appointment, user)
    @appointment = appointment
    @user = user
    mail(to: @user.email, subject: 'Appointment Reminder')
  end
end
