Rails.application.routes.draw do
  root 'cars#index'

  scope defaults: { format: false } do
    resources :cars, only: [:index]
  end

  namespace :admin do
    get '/', to: 'base#index'
  end

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      namespace :ads do
        resources :cars, only: [:index]
      end
      namespace :users do
        resource :profile, only: %i[show]
        resource :session, only: %i[create]
        resource :registration, only: %i[create]
        resources :cars, except: %i[new edit]
      end
    end
  end
end
