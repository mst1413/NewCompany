class V1::ProjectEmployeesController < ApplicationController
  before_action :require_login , :set_selected_project

  def show
    if @project
      if @project.employees != []         
        render json: {status: 'SUCCESS', message:'Loaded employees', data:@project.employees},status: :ok
      else
        render json: {message:"Don't have checed employee in porject id #{params[:project_id]}"}
      end
    else
      render json: {message: "Don't have porject with id #{params[:project_id]}"}      
    end
  end

  def update
    updated_ids = params[:ids]
    if updated_ids.map! { |id| id.to_i }
      EmployeesProject.update_project_employees( updated_ids , @project)
      render json: {status: 'SUCCESS',data:  collection_serializer(@project.employees , V1::EmployeeSerializer)},status: :ok
    else
      EmployeesProject.remove_unchecked_employees(@project.employee_ids, @project)
    end
  end

  private
  def set_selected_project
    @project = current_user.projects.find_by(id: params[:project_id])
  end
end
