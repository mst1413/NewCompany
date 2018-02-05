class V1::PasswordsController < ApplicationController
  before_action :require_login , except: [ :forgot , :recover ]
  
  def forgot
    if !email = params[:email]
      return render json: {error: 'Email not present'}
    end
    # @company = ::Company.find_by(
    # email.include?("@") ? { email: email } : { username: email } )
    # if @company 
    #   @company.generate_password_token
    #   CompanyMailer.recover_password_email(@company , @company.password_reset_token).deliver_now
    #   render_success message: "Please check your e-mail and click the verification link we sent" 
    # else
    #   render_failed message: 'Email address not found. Please check it and try again.' , status: :not_found
    # end
    @company = CompanyAdmin.find_by(email: email.downcase)
    if @company #.present? && company.confirmed_at?
      @company.generate_password_token!
    # SEND EMAIL HERE
      @company.send_recover_email
    # CompanyAdminMailer.recover_password_email(@company , @company.reset_password_token).deliver_later
      render json: {status: 'ok',reset_password_token: @company.reset_password_token}, status: :ok
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end
  
  def reset
    token = params[:reset_password_token]
    company = CompanyAdmin.find_by(reset_password_token: token)
    if company
      if company.reset_password!( params[:password] , params[:password_confirmation])
        company.regenerate_token
        render json: {status: 'SUCCESS' ,message: "Your password changed successfully", data: company}, status: :ok
      else
          render json: {status: 'ERROR', message: "Link not valid or expired."},status: :unprocessable_entity
      end
    else
      render json: {status: 'ERROR', message:'Link not valid or expired. Try generating a new link'},status: :filed
    end
  end

  def update
    if  current_user.authenticate(params[:old_password])
      if  current_user.reset_password!(params[:password], params[:password_confirmation])
        CompanyAdminMailer.password_change_alert(current_user).deliver_now
        current_user.presence_password = true
        render json: {status: 'SUCCESS' ,message: "Your password changed successfully", data: current_user}, status: :ok
      else
        render json: {status: 'ERROR', message: current_user.errors.full_messages},status: :unprocessable_entity
      end
    else
      render json: {status: 'ERROR', message:'Your old password is not correct'},status: :unauthorized
    end
  end   
end