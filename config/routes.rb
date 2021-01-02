Rails.application.routes.draw do


  root to: 'homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }


  scope module: :public do
    resources :users, only:[:edit, :update, :show, :index]
    resources :themes, only:[:index, :create, :new, :show, :destroy]
    resources :answers, only:[:index, :create, :new, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
    end
  end
end
