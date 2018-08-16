Rails.application.routes.draw do
  resource :sessions, only: :create

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :images, only: [:index, :create, :update]
    end
  end
end
