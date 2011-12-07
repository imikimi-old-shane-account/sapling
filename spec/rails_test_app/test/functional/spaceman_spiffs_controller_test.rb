require 'test_helper'

class SpacemanSpiffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spaceman_spiffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spaceman_spiff" do
    assert_difference('SpacemanSpiff.count') do
      post :create, :spaceman_spiff => { }
    end

    assert_redirected_to spaceman_spiff_path(assigns(:spaceman_spiff))
  end

  test "should show spaceman_spiff" do
    get :show, :id => spaceman_spiffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => spaceman_spiffs(:one).to_param
    assert_response :success
  end

  test "should update spaceman_spiff" do
    put :update, :id => spaceman_spiffs(:one).to_param, :spaceman_spiff => { }
    assert_redirected_to spaceman_spiff_path(assigns(:spaceman_spiff))
  end

  test "should destroy spaceman_spiff" do
    assert_difference('SpacemanSpiff.count', -1) do
      delete :destroy, :id => spaceman_spiffs(:one).to_param
    end

    assert_redirected_to spaceman_spiffs_path
  end
end
