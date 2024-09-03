require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = users(:one).tasks.new(title: "MyString",
                                  description: "MyText",
                                  priority: 1,
                                  due_date: Time.now)
  end

  test "should create task with valid attributes" do
    assert @task.save
  end

  test "should not create task without title" do
    @task.title = nil

    assert_raises(ActiveRecord::RecordInvalid, match: "Title can't be blank") do
      @task.save!
    end
  end

  test "should not create task without priority" do
    @task.priority = nil

    assert_raises(ActiveRecord::RecordInvalid, match: "Priority can't be blank") do
      @task.save!
    end
  end

  test "should not create task without due date" do
    @task.due_date = nil

    assert_raises(ActiveRecord::RecordInvalid, match: "Due date can't be blank") do
      @task.save!
    end
  end

  test "should not create task with priority value outside priority list" do
    @task.priority = 4

    assert_raises(ActiveRecord::RecordInvalid, match: "Priority is not included in the list") do
      @task.save!
    end
  end
end
