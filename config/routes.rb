Rails.application.routes.draw do
  post '/games/start', to: 'game_start#call'

  post '/games/:id/roll', to: 'game_roll#call'
end
