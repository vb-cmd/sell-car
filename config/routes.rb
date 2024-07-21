Rails.application.routes.draw do
  root 'ads/cars#index'

  scope module: :ads, as: 'ads', defaults: { format: false } do
    resources :cars, only: %i[index]
  end

  namespace :users, defaults: { format: false } do
    resources :cars, except: %i[show create destroy update]
    resource :profile, except: %i[create new destroy update]
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
        resource :profile, only: %i[show update]
        resource :session, only: %i[create]
        resource :registration, only: %i[create]
        resources :cars, except: %i[new edit]
      end
    end
  end
end
