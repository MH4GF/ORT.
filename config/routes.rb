Rails.application.routes.draw do

  root "docs#about"

  get 'about'    => "docs#about"
  get 'contact'  => "docs#contact"
  get 'terms'    => "docs#terms"
  get 'privacy'  => "docs#privacy"

  # 退会処理のルーティング
  devise_scope :user do
      delete '/users/destroy' => 'devise/registrations#destroy'
    end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations:      'users/registrations' 
                                  }

  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "tags/:id" => "tags#show"

  get "users/mypage" => "users#show", as: "user_root"

end
