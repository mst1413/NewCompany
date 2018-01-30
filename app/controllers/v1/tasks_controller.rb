class V1::TasksController < ApplicationController

    before_action :require_login , :set_company_project || :set_company_employee
    before_action :set_selected_task  , except: [:index , :create]

    def index
        debugger
        if @project.tasks != []        
            render json: {status: 'SUCCESS', message:'Loaded tasks', data:@project.tasks},status: :ok 
        elsif @employee.tasks != []   
            render json: {status: 'SUCCESS', message:'Loaded tasks', data:@employee.tasks},status: :ok
        else
            render json: {message:'The progect or employee dont have tasks'}
        end
    end

    def create
        return render json: {status: 'SUCCESS', message:'New task have been created successfully', data:@new_task},status: :ok if valid_creation
        render json:{message: @new_task.errors.full_messages}
    end

    def update
        if @task.update(task_params)
            render json: {message: "#{@task.name} has been updated successfully" , data:@task}
        else
            render json: {message: @task.errors.full_messages}
        end
    end

    def destroy
        @task.destroy
        render json: {message: "#{@task.name} deleted succesfully " }
    end
  
    private

    def task_params
        params.permit(:name , :description , :assignee_id  , :status)
    end

    def set_company_project
        @project = current_user.projects.find(params[:project_id])
    end

    def set_company_employee
        @employee = current_user.employees.find(params[:employee_id])
    end

    def set_selected_task
        @task = @project.tasks.find(params[:id].to_i)
    end
    
    def project_not_valid
        !current_user.project_ids.include?(params[:project_id].to_i)
    end

    def valid_creation
        @new_task = Task.new(task_params)
        @project.tasks << @new_task
        @new_task.save
    end

end
