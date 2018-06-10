Rails.application.routes.draw do
  root "posts#about"

  # 退会処理のルーティング
  devise_scope :user do
      delete '/users/destroy' => 'devise/registrations#destroy'
    end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }

  get "posts/about" => "posts#about"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  # FIXME docsコントローラーに変えたい
  get "contact" => "posts#contact"
  get "terms" => "posts#terms"
  get "privacy" => "posts#privacy"

  get "tags/:id" => "tags#show"
  get "tags/:id/new" => "posts#new"

  get "users/mypage" => "users#show", as: "user_root"

end
