Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'contact' => 'homes#contact'
  get 'informations' => 'homes#informations'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions',
  }

  namespace :admins do
    resources :informations, only: [:index, :destroy, :create]
    resources :users, only: [:index, :show, :update, :destroy] do
      get 'mytheme' => 'users#mytheme'
      get 'myanswer' => 'users#myanswer'
    end
    resources :themes, only: [:index, :destroy]
    resources :answers, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  scope module: :public do
    match 'tweet' => 'tweets#tweet', :via => :post
    resources :users, only: [:edit, :update, :show, :index] do
      get 'following' => 'users#following'
      get 'follower' => 'users#follower'
      get 'mytheme' => 'users#mytheme'
    end
    resources :relations, only: [:create, :destroy]
    get 'themes/rankindex' => 'themes#rankindex'
    get 'themes/random' => 'themes#random'
    get 'themes/introduction' => 'themes#introduction'
    get 'themes/tagsearch/:theme_tag_name' => 'themes#tagsearch', as: "tagsearch"
    resources :themes, only: [:index, :create, :new, :show]
    get 'answers/rankindex' => 'answers#rankindex'
    get 'answers/followanswer' => 'answers#followanswer'
    resources :answers, only: [:index, :create, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :notifications, only: :index
  end

  # Refileの画像投稿時に404を返さないようにする記述https://qiita.com/ko02/items/99e92956be02ffa5e59b
  mount Refile.app, at: Refile.mount_point, as: :refile_app
  # どこにも当てはまらないPath（例外処理）
  get '*not_found' => 'application#render_404'

end
