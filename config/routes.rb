Rails.application.routes.draw do
  root "dashboard#index"

  # RESTful routes for resources
  resources :students, only: [:index]
  resources :teachers
  resources :classes, only: [:index, :show]  
  resources :results
  resources :payments, only: [:index]
  resources :teachers, only: [:index]


 
end

