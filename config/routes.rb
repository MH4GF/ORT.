Rails.application.routes.draw do
  root "posts#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "tags/index" => "tags#index"
  get "tags/:id" => "tags#show"
  get "tags/:id/new" => "posts#new"
  # post "posts/tweet" => "posts#tweet"

end
