require 'test_helper'
include CarsHelper
class CarsControllerTest < ActionController::TestCase
  setup do
    @car = FactoryGirl.create(:car)
    @user = FactoryGirl.create(:user, email: "test2@test2.com")
    @reservation = FactoryGirl.create(:reservation)
    sign_in(@user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get reservations" do 
    get :get_reservations, :format => :json
    assert_response :success
    assert_not_equal Reservation.count, 0
  end

  test "should get manage page correctly" do
    post :manage
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post :create, car: { for: @car.for, name: @car.name, user_id: @car.user_id }
    end
    assert_redirected_to cars_path
  end

  test "should get edit" do
    get :edit, id: @car
    assert_response :success
  end

  test "should update car" do
    patch :update, id: @car, car: { for: @car.for, name: @car.name, user_id: @car.user_id }
    assert_redirected_to car_path(assigns(:car))
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete :destroy, id: @car
    end
    assert_redirected_to cars_path
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get availability" do 
    params = ActionController::Parameters.new(
      reservation_start: {
        h: (Time.zone.now + 1.hour).strftime('%H'), 
        m: Time.zone.now.strftime('%M')
      }, 
      reservation_end: {
        h: (Time.zone.now + 2.hour).strftime('%H'), 
        m: Time.zone.now.strftime('%M')
      }, 
      date: Date.today + 1.day
    )
    post :get_availability, params
    assert_response :success
  end

  test "should make new reservation" do 
    get :new_reservation
    assert_response :success
  end

  test "should create new reservation" do 
    assert_difference 'Reservation.count' do
      post :save_reservation, reservation_start: Time.zone.now + 2.hour, reservation_end: Time.zone.now + 3.hour, car: @car.id
    end
  end

  test "should not create invalid reservation" do
    post :save_reservation
    assert_redirected_to new_reservation_path
  end

  test "should initially be checked in" do
    assert_nil @car.user
  end

  test "should validate presence of car name" do
    assert_no_difference('Car.count') do
      post :create, car: { for: @car.for, user_id: @car.user_id }
    end
  end

  test "should load the current reservation" do
    get :show_reservation, id: @reservation.id
    assert_response :success
    assert_not_nil assigns(:reservation)
  end

  test "should destroy reservations" do
    delete :destroy_reservation, id: @reservation.id
    assert_response :redirect
  end

  test "should handle dst correctly" do 
    assert_equal fix_dst(Time.utc(0, 0, 12, 1, 1, 2000, 1, 1, false, "-0400")).strftime('%H'), '12'
  end

  test "should not update invalid car" do 
    patch :update, id: @car.id, car: {name: ""}
    assert_not_nil assigns(:car).errors
  end

  test "valid times works properly" do
    assert_not valid_times?(Time.zone.now - 1.hour, Time.zone.now )
  end

  test "car available method" do 
    @car.reservations << @reservation
    assert_not car_available?(@car, Time.zone.now + 2.hour, Time.zone.now + 3.hour)
  end
end
