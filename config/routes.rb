Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "games/:id", to: "score#call"

      post "games/start", to: "start#call"

      post "games/:id/roll", to: "roll#call"
    end
  end
end
