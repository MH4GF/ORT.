Rails.application.routes.draw do
  root "posts#about"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get "posts/about" => "posts#about"
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

  get "users/mypage" => "users#show", as: "user_root"

end
