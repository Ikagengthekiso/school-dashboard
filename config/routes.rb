Rails.application.routes.draw do
  root "dashboard#index"

  # RESTful routes for resources
  resources :students, only: [:index]
  resources :teachers
  resources :classes, only: [:index, :show]  # Assuming you want only index and show actions for classes
  resources :results
  resources :payments, only: [:index]
  resources :teachers, only: [:index]


 
end

