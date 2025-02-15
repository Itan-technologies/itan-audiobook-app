Rails.application.routes.draw do
  get 'admin/index'
  # get 'page/index'
  devise_for :users, path: "", path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: { 
    sessions: 'users/sessions',     
    registrations: 'users/registrations',
    # passwords: 'users/passwords',   
    # confirmations: 'users/confirmations',
    # unlocks: 'users/unlocks',       
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end

  # Defines the root path route ("/")
  root "page#index"

  namespace :admin do
    get 'dashboard', to: 'dashboard#index' # Admin dashboard
    get 'review_book', to: 'books#review' # Example route for uploading a book
    get 'analytics', to: 'analytics#index' # Example route for analytics
  # Add other admin routes here
  end

  namespace :authors do
  get 'dashboard', to: 'dashboard#index'
  get 'upload_book', to: 'books#new' # Example route for uploading a book
  get 'analytics', to: 'analytics#index' # Example route for analytics
  resources :books, only: [:index, :show, :edit, :update] # Example route for managing books
end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
