require 'test_helper'

class CouponControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get coupon_show_url
    assert_response :success
  end

  test "should get new" do
    get coupon_new_url
    assert_response :success
  end

end
