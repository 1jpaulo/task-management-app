require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    post sessions_url, params: { user: { email: "firstuser@example.com", password: "secret" } }
    assert_redirected_to root_path
  end

  test "should destroy session" do
    user = users(:one)
    sign_in(user)
    delete session_url(user.id)
    assert_redirected_to new_session_path
  end
end
