# == Route Map
#
#                          Prefix Verb     URI Pattern                            Controller#Action
#                            root GET      /                                      docs#about
#                       user_root GET      /users/mypage(.:format)                users#show
#                           about GET      /about(.:format)                       docs#about
#                         contact GET      /contact(.:format)                     docs#contact
#                           terms GET      /terms(.:format)                       docs#terms
#                         privacy GET      /privacy(.:format)                     docs#privacy
#                   users_destroy DELETE   /users/destroy(.:format)               devise/registrations#destroy
#                new_user_session GET      /users/sign_in(.:format)               devise/sessions#new
#                    user_session POST     /users/sign_in(.:format)               devise/sessions#create
#            destroy_user_session DELETE   /users/sign_out(.:format)              devise/sessions#destroy
# user_twitter_omniauth_authorize GET|POST /users/auth/twitter(.:format)          users/omniauth_callbacks#passthru
#  user_twitter_omniauth_callback GET|POST /users/auth/twitter/callback(.:format) users/omniauth_callbacks#twitter
#               new_user_password GET      /users/password/new(.:format)          devise/passwords#new
#              edit_user_password GET      /users/password/edit(.:format)         devise/passwords#edit
#                   user_password PATCH    /users/password(.:format)              devise/passwords#update
#                                 PUT      /users/password(.:format)              devise/passwords#update
#                                 POST     /users/password(.:format)              devise/passwords#create
#        cancel_user_registration GET      /users/cancel(.:format)                users/registrations#cancel
#           new_user_registration GET      /users/sign_up(.:format)               users/registrations#new
#          edit_user_registration GET      /users/edit(.:format)                  users/registrations#edit
#               user_registration PATCH    /users(.:format)                       users/registrations#update
#                                 PUT      /users(.:format)                       users/registrations#update
#                                 DELETE   /users(.:format)                       users/registrations#destroy
#                                 POST     /users(.:format)                       users/registrations#create
#                           posts POST     /posts(.:format)                       posts#create
#                        new_post GET      /posts/new(.:format)                   posts#new
#                       edit_post GET      /posts/:id/edit(.:format)              posts#edit
#                            post PATCH    /posts/:id(.:format)                   posts#update
#                                 PUT      /posts/:id(.:format)                   posts#update
#                                 DELETE   /posts/:id(.:format)                   posts#destroy
#                             tag GET      /tags/:id(.:format)                    tags#show

Rails.application.routes.draw do

  root "docs#about"
  get "users/mypage" => "users#show", as: "user_root"

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

  resources :posts, only: [:new, :edit, :create, :update, :destroy]
  resources :tags,  only: [:show]
  
end
