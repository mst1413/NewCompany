Rails.application.routes.draw do

  namespace 'v1' do
    resource :company_admins
    resource :sessions , only: [:create , :destroy ]
    
    
    resource :passwords , only: [:forgot , :reset , :update] do 
      post :forgot  # :collection
      put :reset # :member
    end
    resources :projects do
      resource :project_employees , only: [:show , :update ]
      resources :tasks
    end
    resources :employees do
      resource :employee_projects , only: [:show , :update ]
      resources :tasks
    end
  end
end
