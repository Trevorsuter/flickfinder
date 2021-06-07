Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/movies', to: 'movies#index', as: 'movies'
    end
  end
end
