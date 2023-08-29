Rails.application.routes.draw do
  namespace :admin do
      resources :data_entries

      root to: "data_entries#index"
    end
  resources :data_entries, only: [:create, :update]
  post 'webhook', to: 'web_hooks#webhook'
end
