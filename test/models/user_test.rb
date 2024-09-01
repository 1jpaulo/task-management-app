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

    assert_raises(ActiveRecord::RecordInvalid, match: "Email can't be blank, Email is invalid") do
      @user.save!
    end
  end

  test "should not create user with invalid username" do
    @user.username = nil

    assert_raises(ActiveRecord::RecordInvalid, match: "Username can't be blank") do
      @user.save!
    end
  end

  test "should not create user with duplicated email" do
    @user.email = users(:one).email

    assert_raises(ActiveRecord::RecordInvalid, match: "Email has already been taken") do
      @user.save!
    end
  end

  test "should not create user with duplicated username" do
    @user.username = users(:one).username

    assert_raises(ActiveRecord::RecordInvalid, match: "Username has already been taken") do
      @user.save!
    end
  end
end
