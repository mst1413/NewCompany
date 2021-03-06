class V1::SessionsController < ApplicationController
  before_action :require_login , except: :create 

  def create
    if company = valid_login(params[:email], params[:password])
      company.regenerate_token
      render json: { token: company.token }
    else
      render json: {data: 'Error with your login or password'}
    end
  end

  def destroy
    if current_user
      current_user.update_columns(token: nil)
      render json: {status: 'SUCCESS', message:'logout', data: "https://example.com/login"},status: :ok
    else
      render json: {data: 'User already logged out'}
    end
      # !current_user.nil? ? current_user.update_columns(token: nil) : render_unauthorized("User already logged out")
      # # # current_user.u1pdate_columns(token: nil)   
  end

  def valid_login(login_info , password)
    company = ::CompanyAdmin.find_by(
      login_info.include?("@") ? {email: login_info} : {username: login_info})
      # company = Company.where(email: login_info).or(Company.where(username: login_info )).first
      if company && company.authenticate(password)
        company
      end
  end
end