class NotificationMailer < ActionMailer::Base
  default from: "noreply@pegasus.cs.virginia.edu"

  def test_email(user)
    mail(to: user.email, subject: 'Test Email From Pegasus')
  end

end
