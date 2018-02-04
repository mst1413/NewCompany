class V1::EmployeeProjectsController < ApplicationController
  before_action :require_login , :set_selected_employee

  def show
    if @employee
      if @employee.projects != []      
        render json: {status: 'SUCCESS', message:'Loaded porject', data:@employee.projects},status: :ok
      else
        render json: {message:"Don't have checed porject in employee id #{params[:employee_id]}"}        
      end
    else
        render json: {message: "Don't have employee with id #{params[:employee_id]}"}
    end
  end

  def update
    updated_ids = params[:ids]
    if updated_ids.map! { |id| id.to_i }
      EmployeesProject.update_employee_projects(updated_ids , @employee)    
      render json: {status: 'SUCCESS', message:'Employee projects has been updated successfully"', data:@employee},status: :ok
    else
      EmployeesProject.remove_unchecked_projects( @employee.project_ids , @employee )
      render json: {data: collection_serializer(@employee.projects , V1::ProjectSerializer)}
    end
  end

  private
  def set_selected_employee
    @employee =  current_user.employees.find_by(id: params[:employee_id])
  end
end