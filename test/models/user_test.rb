require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(username: "hey", email: "there@example.com", password: BCrypt::Password.create("secret"))
  end

  test "should create user with valid attributes" do
    assert @user.save
  end

  test "should not create user with invalid email" do
    @user.email = nil
    @user.save

    assert_equal 2, @user.errors.count
    assert_equal 2, (["Email is invalid", "Email can't be blank"] & @user.errors.full_messages).count
  end

  test "should not create user with invalid username" do
    @user.username = nil
    @user.save

    assert_equal 1, @user.errors.count
    assert_equal "Username can't be blank", @user.errors.first.full_message
  end

  test "should not create user with duplicated email" do
    @user.email = users(:one).email
    @user.save

    assert_equal 1, @user.errors.count
    assert_equal "Email has already been taken", @user.errors.first.full_message
  end

  test "should not create user with duplicated username" do
    @user.username = users(:one).username
    @user.save

    assert_equal 1, @user.errors.count
    assert_equal "Username has already been taken", @user.errors.first.full_message
  end
end
