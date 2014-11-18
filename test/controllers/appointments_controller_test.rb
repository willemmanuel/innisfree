require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @appointment = appointments(:one)
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:resident, house_id: 1, id: 2)
    FactoryGirl.create(:resident, house_id: 2, id: 3)
    FactoryGirl.create(:appointment, resident_id: 2)
    FactoryGirl.create(:appointment, resident_id: 3)
    sign_in(@user)
  end

  test "should get index" do
    
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
  end

  test "should create appointment" do
    
    assert_difference('Appointment.count', 1) do
      post :create, appointment: { date: @appointment.date, for: @appointment.for, notes: @appointment.notes, physician_id: @appointment.physician_id, resident_id: @appointment.resident_id, time: @appointment.time, user_id: @appointment.user_id }
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should update appointment" do
    
    patch :update, id: @appointment, appointment: { date: @appointment.date, for: @appointment.for, notes: @appointment.notes, physician_id: @appointment.physician_id, resident_id: @appointment.resident_id, time: @appointment.time, user_id: @appointment.user_id }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should destroy appointment" do
    
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment
    end

    assert_redirected_to appointments_path
  end

  test "filtering on house" do
    
    get :index
    old_count = (@controller.appointments).length
    get :index, {house_id: 1, res_id: ''}
    new_count = (@controller.appointments).length
    assert new_count < old_count, 'old count was ' + old_count.to_s + ' new count is ' + (new_count).to_s
  end

  test "filtering on resident" do
    
    get :index
    old_count = (@controller.appointments).length
    get :index, {house_id: 1, res_id: 2}
    new_count = (@controller.appointments).length
    assert new_count < old_count, 'old count was ' + old_count.to_s + ' new count is ' + (new_count).to_s
  end

  test "filtering residents on house" do
    
    xhr :get, :update_residents, {:house_id => 2, :format => 'js'}
    assert (@controller.residents).length == 1
    xhr :get, :update_residents, {:house_id => '', :format => 'js'}
    assert (@controller.residents).length == (Resident.all).length
  end
end
