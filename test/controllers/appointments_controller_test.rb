require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @type = FactoryGirl.create(:apt_type)
    @user = FactoryGirl.create(:user, admin: true, medical_coordinator: true, email_pref: true)
    @user1 = FactoryGirl.create(:otheruser, email_pref: true)
    FactoryGirl.create(:doctor, id: 1, name: "doc", address: "123 Uni Drive", phone: "123-456-7890")
    FactoryGirl.create(:resident, house_id: 1, id: 2, name: "Pocahontas")
    FactoryGirl.create(:resident, house_id: 2, id: 3, name: "John Smith")
    @appointment = FactoryGirl.create(:appointment, resident_id: 2, date: Date.today, doctor_id: 1, apt_type: @type.id, user: @user)
    @appointment1 = FactoryGirl.create(:appointment, resident_id: 3, date: Date.tomorrow, doctor_id: 1, apt_type: @type.id, user: @user1)
    FactoryGirl.create(:appointment, resident_id: 2, date: Date.yesterday, doctor_id: 1, apt_type: @type.id)
    sign_in(@user)
  end

  test "should get index" do
    
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
  end

  test "should create appointment" do
    
    assert_difference('Appointment.count', 1) do
      post :create, appointment: { date: @appointment.date, apt_type: @appointment.apt_type, notes: @appointment.notes, doctor_id: @appointment.doctor_id, resident_id: @appointment.resident_id, time: @appointment.time , user_id: @user1.id}
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should not create appointment" do
    assert_difference('Appointment.count', 0) do
      assert_raises( ActionController::ParameterMissing){
        post :create, appointment: { }
      }
    end
  end

  test "should update appointment" do
    
    patch :update, id: @appointment, appointment: { date: @appointment.date, apt_type: @appointment.apt_type, notes: @appointment.notes, doctor_id: @appointment.doctor_id, resident_id: @appointment.resident_id, time: @appointment.time, user_id: @appointment.user_id }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should fail updating appointment" do
    assert_raises(ActionController::ParameterMissing){
      patch :update, id: @appointment, appointment: {}
    }
  end

  test "should fail updating appointment and show error page" do
    post :create, id: @appointment, appointment: {resident_id: ''}
    assert_not_nil( @appointment.errors)
    assert :success
  end

  test "should fail creating appointment and show error page" do
    patch :update, id: @appointment, appointment: {resident_id: ''}
    assert_not_nil( @appointment.errors)
    assert :success
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

  test "should not add appointment type" do
    assert_difference('AptType.count', 0) do
      xhr :get, :add_apt_type, {:apt_type => ''}
    end
  end

  test "should show new appointment page" do
    get :new
    assert_not_nil assigns(:residents)
    assert_not_nil assigns(:appointment)
    assert_not_nil assigns(:types)
    assert_not_nil assigns(:upcoming_appointments)
    assert_response :success
  end

  test "should create recurring reminder" do
    assert_difference('RecurringReminder.count', 1) do
      xhr :get, :set_recurring_reminder, {appointment_id: 1, reminder_date: Date.new(2015, 4, 7)}
      assert_not_nil assigns(:reminder)
      assert_response :success
    end
  end

  test "should check appointments_for_day" do
    get :appointments_for_day, {res_id: 2, date: Date.today, house_id: 1}
    assert_equal(false, assigns(:paginate))
    assert_not_nil assigns(:upcoming_appointments)
  end

  test "should check upcoming appointments given resident and house" do
    get :upcoming, {res_id: 2, date: Date.tomorrow, house_id: 1}
    assert_equal(true, assigns(:paginate))
    assert_equal(1, assigns(:upcoming_appointments).count)
    assert_not_nil assigns(:upcoming_appointments)
  end

  test "should check upcoming appointments without specifying resident" do
    get :upcoming, {date: Date.tomorrow, house_id: 1}
    assert_equal(true, assigns(:paginate))
    assert_equal(1, assigns(:upcoming_appointments).count)
    assert_not_nil assigns(:upcoming_appointments)
  end

  test "should check upcoming appointments without resident or house" do
    get :upcoming, {date: Date.tomorrow}
    assert_equal(true, assigns(:paginate))
    assert_equal(2, assigns(:upcoming_appointments).count)
    assert_not_nil assigns(:upcoming_appointments)
  end

  test "should check types variable has all types" do
    get :edit, id: @appointment
    assert_equal(AptType.all, assigns(:types))
  end

  test "should add appointment type" do
    assert_difference('AptType.count', 1) do
      xhr :get, :add_apt_type, {:apt_type => 'type2', :format => 'js'}
    end
    assert_difference('AptType.count', 0) do
      xhr :get, :add_apt_type, {:apt_type => 'type2', :format => 'js'}
    end
 
  end

  test "should send appointment reminder email" do
    post :send_house_reminder, id: @appointment.id
    assert_not ActionMailer::Base.deliveries.empty?
  end

  test "should send non-admin appointment reminder email" do
    post :send_house_reminder, id: @appointment1.id
    assert_not ActionMailer::Base.deliveries.empty?
  end

end
