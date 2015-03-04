every 1.day, :at => '6:00 am' do
  runner "User.send_reminders", environment: 'development'
end

every :sunday, :at => '6:00 am' do
  runner "User.send_weekly_digest", environment: 'development'
end