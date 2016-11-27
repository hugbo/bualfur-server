Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'welcome/index'

  get 'profile/:id', to: 'profile#show_profile'

  post 'properties/search'

  post 'properties/edit'

  get 'profile/:id/edit_profile', to: 'profile#edit_profile'

  resources :properties

  get '/auth/:provider/callback', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

end
