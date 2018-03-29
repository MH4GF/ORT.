Rails.application.routes.draw do
  devise_for :users
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
end
