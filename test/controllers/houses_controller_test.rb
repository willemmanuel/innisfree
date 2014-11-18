require 'test_helper'

class HousesControllerTest < ActionController::TestCase
  setup do
    @house = FactoryGirl.create(:house, name: "The Shire", id:3)
    @user = FactoryGirl.create(:user, name: "Samwise")
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post :create, house: { name: @house.name }
    end

    assert_redirected_to house_path(assigns(:house))
  end

  test "should show house" do
    get :show, id: @house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house
    assert_response :success
  end

  test "should update house" do
    patch :update, id: @house, house: { name: @house.name }
    assert_redirected_to house_path(assigns(:house))
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete :destroy, id: @house
    end
    assert_redirected_to houses_path
  end

  test "should remove house association" do
    @house2 = FactoryGirl.create(:house, name: "Rivendell", id:4)
    @user2 = FactoryGirl.create(:user, house_id: @house2.id, name: "Pippin", email: "me@me.com")
    delete :destroy, id: @house
    assert_nothing_raised{patch :update, id: @user2}
    #assert_equal(@house2, nil)
    #assert_nothing_thrown(patch :update, id: @user2)
    #assert_nil(@user2.house_id)
  end

end
