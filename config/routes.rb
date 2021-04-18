require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'timelines#index'

  resources :timelines do
    resources :comments, only: [:index, :create, :destroy]
  end

  resource :profile, only: [:show, :edit, :update]
  
  namespace :api, defaults: {format: :json} do
    scope '/timelines/:timeline_id' do
      resource :like, only: [:show, :create, :destroy]
      resources :comments, only: [:index, :create, :destroy]
    end
  end
end
