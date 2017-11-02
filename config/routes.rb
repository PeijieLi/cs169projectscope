Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:password]
  resources :comments
  resources :users, :only => [:show, :update] do
    member do
      get 'init', to: 'users#init_new'
      patch 'init', to: 'users#init_update'
    end
  end
  resources :projects do
  	member do
  		post "/add_owner", :to => "projects#add_owner"
      get '/metrics/:metric', :to => 'projects#get_metric_data'
      get '/metrics/:metric/series', :to => 'projects#get_metric_series'
      get '/metrics/:metric/detail', to: 'projects#show_metric'
      get '/metrics/:metric/report', to: 'projects#show_report'
    end
  end
  resources :whitelists, :only => [:index] do
    member do
      put 'upgrade', :to => 'whitelists#upgrade'
      put 'downgrade', :to => 'whitelists#downgrade'
    end
  end

  resources :courses

  resources :tasks do
    member do
      post "/progress", :to => "tasks#progress"
      post "/change_progress", :to => "tasks#change_progress"
    end
  end
  resources :iterations do
    member do
      post "/release", :to => "iterations#release"
    end
  end

  get '/metric_samples/:metric_sample_id/comments',
      :to => 'comments#comments_for_metric_sample',
      :as => 'metric_sample_comments'

  get '/login/:id', :to => 'application#passthru', :as => 'passthru'
  post '/log', to: 'projects#write_log'


  # root 'projects#index'
  root 'courses#index'
end
