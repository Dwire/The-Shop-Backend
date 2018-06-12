Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users

      get '/current_user', to: 'authentications#show'
      post '/login', to: 'authentications#login'
      post '/sign_up', to: 'authentications#create'
      # post '/login', to: 'users#create'
    end
  end
end
