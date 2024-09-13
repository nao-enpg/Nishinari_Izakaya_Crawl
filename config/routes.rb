Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'contact' , to: 'static_pages#contact'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :izakayas, only: %i[index show] do
    collection do
      get :favorites
    end
  end
  resources :favorites, only: %i[create destroy]

  resources :izakaya_plans, only: [:create, :destroy] do
    patch "reorder", on: :member
  end
  resources :plans

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
