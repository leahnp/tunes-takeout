Rails.application.routes.draw do
  # root 'monsters#index'
  # post '/monsters' => 'monsters#favorite', as: :favorite
  # get  '/monsters/:id' => 'monsters#show'

  root 'suggestions#index'

  # retrieve search term from user
  post '/suggestions' => 'suggestions#show', as: 'search'

  # user signin
  get '/signin' => 'users#new', as: 'login'

  # user signout
  delete '/logout' => 'sessions#destroy', as: 'logout'
end
