require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get sessions_home_url
    assert_response :success
  end

  test "should get create" do
    get sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sessions_destroy_url
    assert_response :success
  end

end
