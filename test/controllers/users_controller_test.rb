require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = User.create!(@user_attr)
    @no_name_user = FactoryGirl.create(:user, name: "", email:"example@example.com")
    @main_user = FactoryGirl.create(:user, name: "Rick", email:"rickrick@rick.com", admin: true)
    @request.env['HTTP_REFERER'] = 'http://localhost:3000'
    sign_in(@main_user)

  end

  test "create user" do
    assert_difference('User.count', 1) do
      @user_attr[:email] = "test2@example.com"
      User.create!(@user_attr)
    end
    assert_response :success
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
<<<<<<< HEAD
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
=======

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get pdf with prawnto" do
    get :index, :format => :pdf
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get new with a notice" do
    get :new
    assert_response :success
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should allow user to update himself" do
    patch :update, id: @main_user, user: { password: @main_user.password }
    assert_response :success
  end

  test "should allow admin to update another user's password" do
    patch :update, id: @user, user: { password: @user.password }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should send email reminders" do
    get :send_reminders
    assert_redirected_to :back
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end



>>>>>>> origin/master
end
