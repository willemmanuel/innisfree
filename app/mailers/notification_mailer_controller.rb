class NotificationMailerController < ActionMailer::Base
  default from: "noreply@pegasus.cs.virginia.edu"

  def test_email
    mail(to: "will.emmanuel@gmail.com", subject: 'Welcome to My Awesome Site')
  end

end
