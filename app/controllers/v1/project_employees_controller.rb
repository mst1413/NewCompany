class V1::ProjectEmployeesController < ApplicationController
  before_action :require_login
  
  before_action :set_selected_project #, except: [:index , :create ]

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
    @updated_ids = params[:ids]
    if @updated_ids.map! { |id| id.to_i }
      return render json: {message: 'Invalid IDs assigned'}, status: :unprocessable_entity if assigning_invalid_ids == true 
      EmployeesProject.delete_unchecked_employees(@unchecked_ids , params[:project_id] )     if @unchecked_ids = @project.employee_ids - @updated_ids 
      EmployeesProject.assign_new_checked_employees(@new_assigned_ids , params[:project_id] ) if @new_assigned_ids = @updated_ids - @project.employee_ids
      render json: {status: 'SUCCESS', message:'project employees has been updated successfully', data:@project},status: :ok
      # Project.find(params[:project_id])
    end
  end

  private
  
  def set_selected_project
    @project = current_user.projects.find_by(id: params[:project_id])
  end

  def assigning_invalid_ids
    return false if @updated_ids == ( nil || [0] )

    @updated_ids.each do |id| 
      return true if !id.in?( current_user.employee_ids )    
    end
  end
  
end
