require 'test_helper'

class LawyerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get lawyer_new_url
    assert_response :success
  end

  test "should get create" do
    get lawyer_create_url
    assert_response :success
  end

  test "should get edit" do
    get lawyer_edit_url
    assert_response :success
  end

  test "should get update" do
    get lawyer_update_url
    assert_response :success
  end

  test "should get show" do
    get lawyer_show_url
    assert_response :success
  end

  test "should get destroy" do
    get lawyer_destroy_url
    assert_response :success
  end

end
