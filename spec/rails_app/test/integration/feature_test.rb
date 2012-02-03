require 'test_helper'

class FeatureTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "users can 'log in'" do
    post user_sessions_path, :user_id => 1
    get user_sessions_path
    assert_equal '1', response.body
  end

  test "users cant use 'my_custom_test_feature'" do
    # user1 is listed, user2 is not
    assert Sapling::ActiveRecord.new.features[:my_custom_test_feature].users[1]
    assert_nil Sapling::ActiveRecord.new.features[:my_custom_test_feature].users[2]

    # but user1 is denied
    post user_sessions_path, :user_id => 1
    get custom_test_feature_spaceman_spiffs_path
    assert_equal '0', response.body

    # and user2 is permitted
    post user_sessions_path, :user_id => 2
    get custom_test_feature_spaceman_spiffs_path
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

  test "has a feature_on block" do
    # TODO
  end


end
