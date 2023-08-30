Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  namespace :admin do
      resources :data_entries
      resources :api_links

      root to: "data_entries#index"
    end
  resources :data_entries, only: [:create, :update]
  post 'webhook', to: 'web_hooks#webhook'
end
