class NotificationMailer < ActionMailer::Base
  helper :application
  default from: "noreply@pegasus.cs.virginia.edu"
  def appointment_digest(user)
  	@user = user
  	@appointments = Appointment.where('date = ?', Date.today)
    mail(to: user.email, subject: 'Today\'s Innisfree Appointments')
  end

  def weekly_digest(user)
    @user = user
    @appointments = Appointment.where('date >= ?', Date.tomorrow).where('date <= ?', Date.tomorrow+7)
    mail(to: user.email, subject: 'This week\'s Innisfree Appointments')
  end

  def appointment_reminder(appointment)
  	@appointment = appointment
  	mail(to: @appointment.user.email, subject: 'Upcoming appointment today')
  end

  def appointment_assignment_notification(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Appointment Assignment Notification')
  end  

  def recurring_appointment_reminder(appointment)
  	@appointment = appointment
    user = User.where('id = ?', @appointment.user_id)[0];
  	mail(to: user.email, subject: 'Schedule Follow-up Appointment')
  end

  def new_appointment_notification(appointment, user)
    @appointment = appointment
    @user = user
    mail(to: @user.email, subject: 'New Appointment Scheduled')
  end

  def house_reminder(appointment, user)
    @appointment = appointment
    @user = user
    mail(to: @user.email, subject: 'Appointment Reminder')
  end
end
