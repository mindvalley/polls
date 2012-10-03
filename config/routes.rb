CommunityAwards::Application.routes.draw do
  get "downloads/voters"

  resources :results, only: [:index, :show]

  resources :ballots

  resources :employees

  root to: 'home#index'

  post 'uploads/employees'
  post 'uploads/salaries'
  post 'downloads/voters'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end
end
