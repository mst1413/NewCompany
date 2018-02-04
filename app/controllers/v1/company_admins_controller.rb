class V1::CompanyAdminsController < ApplicationController
  before_action :require_login , except: [:create , :index]
  
  def index
    companies = CompanyAdmin.order('created_at DESC');
    render json: {status: 'SUCCESS', message:'Loaded companies', data:companies},status: :ok
  end

  def show
      company = current_user
      render json: {status: 'SUCCESS', message:'Loaded company', data:company},status: :ok 
  end

  def create
      @company = CompanyAdmin.new(company_params)
      if @company.save
          # CompanyAdminMailer.welcome_email(@company).deliver_now
          @company.regenerate_token
          render json: {status: 'SUCCESS', message:'Saved company', data:@company},status: :ok
      else
          render json: {status: 'ERROR', message:'Company not saved', data:@company.errors},status: :filed
      end
  end

  def destroy
      company = current_user
      company.destroy
      render json: {status: 'SUCCESS', message:'Deleted company', data:company},status: :ok
  end

  def update
      company = current_user
      if company.update(company_params)
          render json: {status: 'SUCCESS', message:'Saved company', data:company},status: :ok
      else
          render json: {status: 'ERROR', message:'Company not saved', data:company.errors},status: :filed
      end
  end
  
  private 
  def company_params
      params.permit(:company_name, :username, :email, :logo, :password, :password_confirmation )
  end
end