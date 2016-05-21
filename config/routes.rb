Rails.application.routes.draw do
  # root 'monsters#index'
  # post '/monsters' => 'monsters#favorite', as: :favorite
  # get  '/monsters/:id' => 'monsters#show'

  root 'suggestions#index'

  # retrieve search term from user
  # should this be a get?
  post '/suggestions' => 'suggestions#show', as: 'search'

  # user signin
  get '/signin' => 'users#new', as: 'login'

  # user signout
  delete '/logout' => 'sessions#destroy', as: 'logout'

  # let a user favorite a pairing
  post '/favorite' => 'suggestions#favorite', as: 'favorite'

  # let a user unfavorite a pairing
  delete '/favorite' => 'suggestions#destroy_favorite', as: 'destroy_favorite'

  # show list of favorites for current user
  get '/favorites' => 'suggestions#favorites', as: 'favorites'

  # login with spotify
  get "/auth/:provider/callback" => "sessions#create"
end
