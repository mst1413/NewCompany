
        class V1::CompanyAdminsController < ApplicationController
            def index
                companies = CompanyAdmin.order('created_at DESC');
                render json: {status: 'SUCCESS', message:'Loaded companies', data:companies},status: :ok
                
            end
            def show
                company = CompanyAdmin.find(params[:id])
                render json: {status: 'SUCCESS', message:'Loaded company', data:company},status: :ok
                
            end
            def create
                company = CompanyAdmin.new(company_params)
                if company.save
                    render json: {status: 'SUCCESS', message:'Saved company', data:company},status: :ok
                    
                else
                    render json: {status: 'ERROR', message:'Company not saved', data:company.errors},status: :filed
                    
                end
                
            end
            def destroy
                company = CompanyAdmin.find(params[:id])
                company.destroy
                render json: {status: 'SUCCESS', message:'Deleted company', data:company},status: :ok
                
            end
            def update
                company = CompanyAdmin.find(params[:id])
                if company.update_attributes(company_params)
                    render json: {status: 'SUCCESS', message:'Saved company', data:company},status: :ok
                    
                else
                    render json: {status: 'ERROR', message:'Company not saved', data:company.errors},status: :filed
                    
                end
                
            end
            private
            def company_params
                params.permit(:username, :password, :email, :companyname, :logo)
            end
        end
