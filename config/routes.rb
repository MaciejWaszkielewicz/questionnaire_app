Rails.application.routes.draw do
  root "survey#index"
  resources :surveys, only: :index do
    resources :approaches, only: [:index, :show, :destroy] do
      resources :answers, only: [:edit, :update]
    end
    resources :sections, only: [] do
      resources :approaches, only: [:new, :create]
    end
  end
end
