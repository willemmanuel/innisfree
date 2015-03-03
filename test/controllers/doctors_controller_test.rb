require 'test_helper'

class DoctorsControllerTest < ActionController::TestCase
  setup do
    @doctor = FactoryGirl.create(:doctor)
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doctors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doctor" do
    assert_difference('Doctor.count') do
      post :create, doctor: { address: @doctor.address, name: @doctor.name, phone: @doctor.phone }
    end

    assert_redirected_to new_doctor_path
  end

  test "should show doctor" do
    get :show, id: @doctor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doctor
    assert_response :success
  end

  test "should update doctor" do
    patch :update, id: @doctor, doctor: { address: @doctor.address, name: @doctor.name, phone: @doctor.phone }
    assert_redirected_to doctor_path(assigns(:doctor))
  end

  test "should not create doctor with missing name" do
    assert_no_difference('Doctor.count') do
    post :create, doctor: { address: @doctor.address, phone: @doctor.phone }
    end
  end

  test "should not create doctor with missing phone" do
    assert_difference('Doctor.count') do
      post :create, doctor: { address: @doctor.address, name: @doctor.name }
    end
      assert_response :redirect
  end

  test "should not create doctor with missing address" do
    assert_difference('Doctor.count') do
      post :create, doctor: { name: @doctor.name, phone: @doctor.phone }
    end
     assert_response :redirect
  end

  test "should not create doctor with name only" do
    assert_difference('Doctor.count') do
      post :create, doctor: { name: @doctor.name }
    end
      assert_response :redirect
  end

  test "should not create doctor with address only" do
    assert_no_difference('Doctor.count') do
      post :create, doctor: { address: @doctor.address }
    end
  end

  test "should destroy doctor" do
    assert_difference('Doctor.count', -1) do
      delete :destroy, id: @doctor
    end
    assert_redirected_to doctors_path
  end
end
