Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create] do
    resources :habits, only: [:index, :create, :show, :update] do
      resources :reminders, only: [:create]
    end
  end
end
