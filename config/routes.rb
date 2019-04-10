Rails.application.routes.draw do
  # TO DO set the heroku url below
  default_url_options :host => 'https://password111.herokuapp.com/'
  
  root   'static_pages#home'
  
  get 'password_resets/new'
 
  get    '/help',    to: 'static_pages#help'
  get    '/checklist',    to: 'static_pages#checklist'
  post   '/checklist',    to: 'test#create'
  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/try',   to: 'static_pages#try'
  post '/call', to: 'twilio#call', as: 'call'
  post '/connect/:sales_number', to: 'twilio#connect', as: 'connect'
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
end