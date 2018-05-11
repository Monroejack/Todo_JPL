module Api::V1

  class TasksController < ApiController

    before_action :authenticate_user
    before_action :set_task, only: [:show]

    def index

      @tasks = Task.where(user: current_user)
      render json: @tasks
    end

    def show
      render json: @task
    end

    def create
      @task = Task.new(task_params)

      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors
    end
  end

    private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :priority, :user_id, :due_date)
    end
  end
end
