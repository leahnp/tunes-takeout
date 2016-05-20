Rails.application.routes.draw do
  # root 'monsters#index'
  # post '/monsters' => 'monsters#favorite', as: :favorite
  # get  '/monsters/:id' => 'monsters#show'

  root 'suggestions#index'

  # retrieve search term from user
  post '/suggestions' => 'suggestions#show', as: 'search'
  # get '/suggestions' => 'suggestions#show'

  # user signin
  get '/signin' => 'users#new', as: 'login'

  # user signout
  delete '/logout' => 'sessions#destroy', as: 'logout'

  # let a user favorite a pairing
  post '/favorite' => 'suggestions#favorite', as: 'favorite'

  # show list of favorites for current user
  get '/favorites' => 'suggestions#favorites', as: 'favorites'

  # login with spotify
  get "/auth/:provider/callback" => "sessions#create"
end
