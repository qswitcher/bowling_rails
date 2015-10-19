Rails.application.routes.draw do
  resources :games, defaults: { format: 'json' }
  resources :frames, defaults: { format: 'json' }
end
