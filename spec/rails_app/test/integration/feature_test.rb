require 'test_helper'

class FeatureTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "users can 'log in'" do
    post user_sessions_path, :user_id => 1
    get user_sessions_path
    assert_equal '1', response.body
  end

  test "listing is enabled for user one" do
    post user_sessions_path, :user_id => 1
    get spaceman_spiffs_path
    assert_response :success
  end

  test "listing is disabled for user two" do
    post user_sessions_path, :user_id => 2
    get spaceman_spiffs_path
    assert_response :forbidden
  end

end
