require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = User.create!(@user_attr)
    @no_name_user = FactoryGirl.create(:user, name: "", email:"example@example.com")
  end

  test "create user" do
    assert_difference('User.count', 1) do
      @user_attr[:email] = "test2@example.com"
      User.create!(@user_attr)
    end
  end

  test "successful login" do
    sign_in(@user)
    assert_response :success
  end

  test "user is admin" do
     assert @user_attr[:admin] == true
     assert @user.admin == true
  end

  test "user is approved" do
    assert @user.approved == true
  end

  test "delete user" do
    assert_difference('User.count', -1) do
      User.delete(@user)
    end
  end

  test "user with no name" do
    assert(@no_name_user.name == "example@example.com")  
  end
=begin
  test "send_recurring_reminders_test" do
     c = NotificationMailer.deliveries.count
     recur = RecurringReminder.new
     app = Appointment.new
     recur.notification_date = Date.today
     recur.appointment_id = app.id
     recur.save
     u = User.new
     u.email_pref = true
     app.user=u.id    
     app.date = Date.today
     app.save
     u.send_reminders 
     assert(NotificationMailer.deliveries.count - c == 1)
   end
=end
end
