require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = User.create(@user_attr)
    @no_name_user = FactoryGirl.create(:user, name: nil, email: "noname@test.com")
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
    assert(@no_name_user.name == "noname@test.com")  
  end

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

end
