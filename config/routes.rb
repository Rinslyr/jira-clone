Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"

  resources :projects do
    resources :tickets
  end

  resources :projects do
    resources :tickets
  end

  resources :projects do
    resources :tickets do
      collection do
        get 'kanban'
      end
    end
  end

  resources :projects do
    resources :tickets do
      resources :comments, only: [:create]
    end
  end

  resources :projects

  resources :projects
end