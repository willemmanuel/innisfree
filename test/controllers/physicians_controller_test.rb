require 'test_helper'

class PhysiciansControllerTest < ActionController::TestCase
  setup do
    @physician = FactoryGirl.create(:physician)
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:physicians)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create physician" do
    assert_difference('Physician.count') do
      post :create, physician: { address: @physician.address, name: @physician.name, phone: @physician.phone }
    end

    assert_redirected_to physician_path(assigns(:physician))
  end

  test "should show physician" do
    get :show, id: @physician
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @physician
    assert_response :success
  end

  test "should update physician" do
    patch :update, id: @physician, physician: { address: @physician.address, name: @physician.name, phone: @physician.phone }
    assert_redirected_to physician_path(assigns(:physician))
  end

  test "should not create physician with missing name" do
    assert_difference('Physician.count') do
      post :create, physician: { address: @physician.address, phone: @physician.phone }
    end
      assert_response :redirect
  end

  test "should not create physician with missing phone" do
    assert_difference('Physician.count') do
      post :create, physician: { address: @physician.address, name: @physician.name }
    end
      assert_response :redirect
  end

  test "should not create physician with missing address" do
    assert_difference('Physician.count') do
      post :create, physician: { name: @physician.name, phone: @physician.phone }
    end
      assert_response :redirect
  end

  test "should not create physician with name only" do
    assert_difference('Physician.count') do
      post :create, physician: { name: @physician.name }
    end
      assert_response :redirect
  end

  test "should not create physician with address only" do
    assert_difference('Physician.count') do
      post :create, physician: { address: @physician.address }
    end
      assert_response :redirect
  end

  test "should destroy physician" do
    assert_difference('Physician.count', -1) do
      delete :destroy, id: @physician
    end
    assert_redirected_to physicians_path
  end
end
