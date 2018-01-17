Rails.application.routes.draw do
  namespace 'v1' do
    resources :company_admins
  end
end
