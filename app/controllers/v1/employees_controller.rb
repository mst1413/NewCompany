class V1::EmployeesController < ApplicationController
  before_action :require_login
  before_action :set_company_employee , except: [:index , :create ]

  def index
    employees = Employee.order('created_at DESC');
    if employees != []         
      render json: {status: 'SUCCESS', message:'Loaded employees', data:employees},status: :ok
    else
      render json: {message:'Employees are empty'}
    end 
  end

  def create
    employee = current_user.employees.new(employee_params)
    if employee.save           
      render json: {status: 'SUCCESS', message:'Saved employee', data:employee},status: :ok
    else
      render json: {status: 'ERROR', message:'Employee not saved', data:employee.errors},status: :filed
    end
  end
  
  def show
    if @employee
      render json: {status: 'SUCCESS', message:'Loaded employee', data: V1::EmployeeDetailsSerializer.new(@employee)},status: :ok
    else
      render json: {status: 'ERROR', message:"don't have employee id #{params[:id]}"},status: :filed
    end 
  end

  def destroy
    if @employee
      @employee.destroy! 
      render json: {status: 'SUCCESS', message:'Deleted employee'},status: :ok
    else
      render json: {message: "can not delete record with id #{params[:id]}"}
    end
  end
          
  def update
    if @employee
      @employee.update!(employee_params)
      render json: {status: 'SUCCESS', message:'Updated employee', data:@employee},status: :ok
    else
      render json: {status: 'ERROR', message:"Don't have employee id #{params[:id]}"},status: :filed
    end
  end
  
  private
  def employee_params
    params.permit(:name, :joining_date, :birthdate)
  end

  def set_company_employee
    @employee =  current_user.employees.find_by(id: params[:id])
  end
end