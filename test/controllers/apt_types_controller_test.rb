require 'test_helper'

class AptTypesControllerTest < ActionController::TestCase

  setup do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in(@user)
  end

  test "should get destroy" do
    @typ = FactoryGirl.create(:apt_type, apt_type: 'type1')
    delete :destroy, id: @typ.id
    assert_redirected_to new_appointment_path 
  end

end
