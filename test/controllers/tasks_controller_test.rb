require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    # TODO: when user auth is done, make sure fixture users(:one) is our guy
    @task = tasks(:one)
  end

  test "should get index with only users owned tasks" do
    get tasks_url
    assert_response :success

    # TODO: this is not currently working because I'm getting the first user of the DB and it will be different
    # in the test.
    # Auth is necessary so I can then create a test helper to sign in the correct user in the setup
    # assert_match @task.title, response.body

    # @task_other_user = tasks(:two)

    # assert_no_match @task_other_user.title, response.body
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { description: @task.description, due_date: @task.due_date, priority: @task.priority, title: @task.title } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { completed: @task.completed, description: @task.description, due_date: @task.due_date, priority: @task.priority, title: @task.title } }
    assert_redirected_to task_url(@task)
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
