Rails.application.routes.draw do
  post '/authenticate', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      get '/example', to: 'my_seven#example_endpoint'
    end
  end
end
