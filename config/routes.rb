Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/games/start', to: 'start#call'

      post '/games/:id/roll', to: 'roll#call'
    end
  end
end
