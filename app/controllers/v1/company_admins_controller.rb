class V1::CompanyAdminsController < ApplicationController
  before_action :require_login , except: [:create , :index]
  
  def show
    render json: { status: 'SUCCESS', message:'Loaded company', data: V1::CompanyAdminSerializer.new(current_user) }
  end

  def create
    @company = CompanyAdmin.new(company_params)
    @company.save ? (render json: { status: 'SUCCESS', message:'Saved company', data: V1::CompanyAdminSerializer.new(@company) })
                  : (render json: { status: 'ERROR', message:'Company not saved', data:@company.errors })
  end

  def destroy
    render json: { status: 'SUCCESS', message:'Deleted company', data: current_user.destroy },status: :ok
  end

  def update
    company = current_user
    company.update(company_params) ? (render json:{ status: 'SUCCESS', message:'Saved company', data:V1::CompanyAdminSerializer.new(company) })
                                   : (render json:{ status: 'ERROR', message:'Company not saved', data:company.errors })
  end
  
  private 
  def company_params
    params.permit(:companyname, :username, :email, :logo, :password, :password_confirmation)
  end
end
