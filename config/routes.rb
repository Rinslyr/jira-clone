Rails.application.routes.draw do
  devise_for :users
  
  # Root route
  root to: "projects#index"

  # Standalone tickets route for global ticket list
  resources :tickets, only: [:index]

  # Nested routes
  resources :projects do
    resources :tickets do
      collection do
        get 'kanban'
      end
      resources :comments, only: [:create]
    end
  end
end