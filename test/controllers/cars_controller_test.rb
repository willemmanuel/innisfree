require 'test_helper'

class CarsControllerTest < ActionController::TestCase
  setup do
    @car = FactoryGirl.create(:car)
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  test "should get new" do
    get :new
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

  test "should initially be checked in" do
    assert_nil @car.user
  end

  test "should redirect to cars index" do
    @request.env['HTTP_REFERER'] = 'http://test.host/cars'
    patch :toggle, id: @car
    assert_redirected_to cars_path
  end

  test "should validate presence of car name" do
    assert_no_difference('Car.count') do
      post :create, car: { for: @car.for, user_id: @car.user_id }
    end
  end

  test "should checkout car" do
    @request.env['HTTP_REFERER'] = 'http://test.host/cars'
    put :toggle, id: @car 
    c = Car.where(name: @car.name).first
    assert_equal c.user.id, @user.id
  end
end
