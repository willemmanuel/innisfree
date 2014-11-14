require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = User.create!(@user_attr)
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

end
