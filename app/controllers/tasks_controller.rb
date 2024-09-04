class TasksController < ApplicationController
  before_action :current_user
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    priority_order = params[:priority_order].in?(%w[asc desc]) ? params[:priority_order] : nil
    due_date_order = params[:due_date_order].in?(%w[asc desc]) ? params[:due_date_order] : nil

    @tasks = @user.tasks.paginate(page: params[:page], per_page: 3)
    @tasks = @tasks.order(due_date: due_date_order) if due_date_order
    @tasks = @tasks.order(priority: priority_order) if priority_order
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @user.tasks.new(create_task_params)
    if @task.save
      redirect_to task_url(@task), notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(update_task_params)
      redirect_to task_url(@task), notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = @user.tasks.find(params[:id])
  end

  def create_task_params
    params.require(:task).permit(:title, :description, :priority, :due_date)
  end

  def update_task_params
    params.require(:task).permit(:title, :description, :priority, :due_date, :completed)
  end
end
