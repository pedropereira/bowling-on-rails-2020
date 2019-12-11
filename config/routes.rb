Rails.application.routes.draw do
  post '/games/start', to: 'game_start#call'
end
