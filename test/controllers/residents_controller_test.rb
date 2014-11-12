require 'test_helper'

class ResidentsControllerTest < ActionController::TestCase
  setup do
    @resident = residents(:one)
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resident" do
    assert_difference('Resident.count') do
      post :create, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    end

    assert_redirected_to resident_path(assigns(:resident))
  end

  test "should get edit" do
    get :edit, id: @resident
    assert_response :success
  end

  test "should update resident" do
    patch :update, id: @resident, resident: { house_id: @resident.house_id, name: @resident.name, notes: @resident.notes }
    assert_redirected_to resident_path(assigns(:resident))
  end

  test "should destroy resident" do
    assert_difference('Resident.count', -1) do
      delete :destroy, id: @resident
    end

    assert_redirected_to residents_path
  end
end
