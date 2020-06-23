require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get store_show_url
    assert_response :success
  end

  test "should get new" do
    get store_new_url
    assert_response :success
  end

end
