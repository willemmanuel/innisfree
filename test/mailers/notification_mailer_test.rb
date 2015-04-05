require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  setup do 
    @user = FactoryGirl.create(:user, email: "notification@notification.com")
    @appointment = FactoryGirl.create(:appointment, user: @user)
  end

  test "should create emails" do
  	email = NotificationMailer.appointment_assignment_notification(@appointment)
  	assert_not_nil email
  	email = NotificationMailer.new_appointment_notification(@appointment, @user)
  	assert_not_nil email
  	email = NotificationMailer.house_reminder(@appointment, @user)
  	assert_not_nil email
  end

  test "should send email" do 
  	email = NotificationMailer.appointment_assignment_notification(@appointment).deliver
  	assert_not ActionMailer::Base.deliveries.empty?
  end


end


# class UserMailerTest < ActionMailer::TestCase
#   test "invite" do
#     # Send the email, then test that it got queued
#     email = UserMailer.create_invite('me@example.com',
#                                      'friend@example.com', Time.now).deliver_now
#     assert_not ActionMailer::Base.deliveries.empty?
#  
#     # Test the body of the sent email contains what we expect it to
#     assert_equal ['me@example.com'], email.from
#     assert_equal ['friend@example.com'], email.to
#     assert_equal 'You have been invited by me@example.com', email.subject
#     assert_equal read_fixture('invite').join, email.body.to_s
#   end
# end