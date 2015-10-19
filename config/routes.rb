Rails.application.routes.draw do
  apipie
  resources :games, defaults: { format: 'json' }
  resources :frames, defaults: { format: 'json' }
end
