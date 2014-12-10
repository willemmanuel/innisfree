every 1.day, :at => '6:00 am' do
  runner "User.send_reminders", environment: 'development'
end