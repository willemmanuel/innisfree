require 'test_helper'

class ResidentsControllerTest < ActionController::TestCase
  setup do
    @resident = FactoryGirl.create(:resident)
    @user = FactoryGirl.create(:user)
    @house = FactoryGirl.create(:house)
    @house2 = FactoryGirl.create(:house2)
    @volunteer1 = FactoryGirl.create(:user, email: 'volunteer1@test.com', admin: false, house_id: 1)
    @volunteer2 = FactoryGirl.create(:user, email: 'volunteer2@test.com', admin: false, house_id: 2)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:residents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show resident" do
    get :show, id: @resident
    assert_response :success
  end

  test "should create resident" do
    assert_difference('Resident.count') do
      post :create, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    end
    assert_redirected_to new_resident_path
  end

  test "volunteer should not create resident" do
    sign_in(@volunteer1)

    assert_no_difference('Resident.count') do
      post :create, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    end

    assert_redirected_to houses_path
  end

  test "should get edit" do
    get :edit, id: @resident
    assert_response :success
  end

  test "volunteer should get edit" do
    sign_in(@volunteer1)

    get :edit, id: @resident
    assert_response :success
  end

  test "wrong house volunteer should not get edit" do
    sign_in(@volunteer2)

    get :edit, id: @resident
    assert_redirected_to houses_path
  end

  test "should update resident" do
    patch :update, id: @resident, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    assert_redirected_to resident_path(assigns(:resident))
  end

  test "volunteer should update resident" do
    sign_in(@volunteer1)

    patch :update, id: @resident, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    assert_redirected_to resident_path(assigns(:resident))
  end

  test "wrong house volunteer should not update resident" do
    sign_in(@volunteer2)

    patch :update, id: @resident, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    assert_redirected_to houses_path
  end

  test "should destroy resident" do
    assert_difference('Resident.count', -1) do
      delete :destroy, id: @resident
    end

    assert_redirected_to residents_path
  end

  test "volunteer should not destroy resident if not in the same house" do
    sign_in(@volunteer2)

    assert_no_difference('Resident.count') do
      delete :destroy, id: @resident
    end

    assert_redirected_to houses_path
  end
end
