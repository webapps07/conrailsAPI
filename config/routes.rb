Rails.application.routes.draw do
  resources :leaders
  resources :promotions
  resources :feedbacks
  resources :dishes
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
