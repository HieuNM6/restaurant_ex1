require 'test_helper'

class WellcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get menu" do
    get :menu
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
