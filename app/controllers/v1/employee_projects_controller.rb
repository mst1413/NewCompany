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
      # return render json: {message: " Invalid IDs assigned " , status: :unprocessable_entity} if assigning_invalid_ids == true  
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

  # def assigning_invalid_ids
  #   return false if @updated_ids == ( nil || [0] )

  #   @updated_ids.each do |id| 
  #     return true if !id.in?( current_user.project_ids )    
  #   end
  end


# def show
#   render_success( data: ActiveModel::Serializer::CollectionSerializer.new( 
#       current_company.projects , serializer: V1::EmployeeProjectsSerializer , scope: {emp: @employee}
#   ))
# end


