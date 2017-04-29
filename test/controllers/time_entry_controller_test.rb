require 'test_helper'

class TimeEntryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get time_entry_new_url
    assert_response :success
  end

  test "should get create" do
    get time_entry_create_url
    assert_response :success
  end

  test "should get edit" do
    get time_entry_edit_url
    assert_response :success
  end

  test "should get update" do
    get time_entry_update_url
    assert_response :success
  end

  test "should get show" do
    get time_entry_show_url
    assert_response :success
  end

  test "should get destroy" do
    get time_entry_destroy_url
    assert_response :success
  end

end
