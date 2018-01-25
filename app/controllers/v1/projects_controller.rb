class V1::ProjectsController < ApplicationController
    before_action :require_login
    before_action :set_company_project , except: [:index , :create ]    

    def index
        projects = Project.order('created_at DESC');
        if projects != []        
            render json: {status: 'SUCCESS', message:'Loaded projects', data:projects},status: :ok
        else
            render json: {message:'Projects are empty'}
        end
        
    end

    def create
        project = current_user.projects.new(project_params)
        
        if project.save           
            render json: {status: 'SUCCESS', message:'Saved project', data:project},status: :ok
            
        else
            render json: {status: 'ERROR', message:'Project not saved', data:project.errors},status: :filed
            
        end
        
    end

    def show
        if @project
            render json: {status: 'SUCCESS', message:'Loaded project', data:@project},status: :ok
        else
            render json: {status: 'ERROR', message:"don't have project id #{params[:id]}"},status: :filed
        end 
    end

    def destroy
        if @project
            @project.destroy! 
            render json: {status: 'SUCCESS', message:'Deleted project'},status: :ok
        else
            render json: {message: "can not project record with id #{params[:id]}"}
        end
    end

    def update
        if @project
            @project.update!(project_params)
            render json: {status: 'SUCCESS', message:'Updated project', data:@project},status: :ok
            
        else
            render json: {status: 'ERROR', message:"Don't have project id #{params[:id]}"},status: :filed
            
        end
        
    end
    

    private
    def project_params
        params.permit(:name, :description)
    end

    def set_company_project
        @project =  current_user.projects.find_by(id: params[:id])
    end


end
