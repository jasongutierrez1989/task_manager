class TasksController < ApplicationController
    before_action :require_login
    before_action :set_location, only: [:edit, :update]
    before_action :set_task, only: [:show, :edit, :update]

    def index
        @tasks = Task.all
        if params[:location_id]
            @task = Task.new(location_id: params[:location_id])
        else
            @task = Task.new
        end
    end

    def new
        @task = Task.new(location_id: params[:location_id])
    end

    def create
        @task = Task.new(task_params)
        if @task.save!
            redirect_to task_path(@task)
        else
            redirect_to new_task_path(@task), error: "Error: #{@task.errors.full_messages.join(", ")}"
        end
    end

    def show
        @task = Task.find_by(id: params[:id])
    end

    def edit
        @task = Task.find_by(id: params[:id])
        render :edit
    end

    def update
        @task = Task.find_by(id: params[:id])

        @task.update(task_params)
        if @task.save
            redirect_to task_path(@task)
        else
            redirect_to edit_task_path(@task), error: "Error: #{@task.errors.full_messages.join(", ")}"
        end
    end

    def destroy
        Task.find(params[:id]).destroy
        flash[:notice] = "Task deleted."
        redirect_to '/tasks/'
    end

    
    private

    def task_params
        params.require(:task).permit(:name, :description, :user_id, :location_id, :user_name)
    end

    def set_task
        @task = Task.find_by(:location_id => params[:location_id], :id => params[:id])
    end

    def set_location
        @location = Location.find_by(id: params[:location_id])
    end
end