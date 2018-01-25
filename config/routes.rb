Rails.application.routes.draw do
  namespace 'v1' do
    resource :company_admins
    resource :sessions , only: [:create , :destroy ]
    resource :passwords , only: [:forgot , :reset , :update] do 
      post :forgot  # :collection
      put :reset # :member
    end
    resources :projects
    resources :employees
  end
end
