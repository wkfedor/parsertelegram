Rails.application.routes.draw do
  resources :messages
  resources :dopmygroups
  get 'debug100', to: 'messages#debug100'

  get 'workdbavto', to: 'twoloadfiles#workdbavto'
  post 'workdbavto', to: 'twoloadfiles#workdbavto'
  get 'workdbpage', to: 'twoloadfiles#workdbpage'
  post 'onlinestatupdatedb', to: 'twoloadfiles#onlinestatupdatedb'
  get 'onlinestatupdatedb', to: 'twoloadfiles#onlinestatupdatedb'

  resources :twoloadfiles
  resources :loadfiles

  resources :wfiles
  resources :mygroups
  root 'mygroups#index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
