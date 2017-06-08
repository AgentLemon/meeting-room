Rails.application.routes.draw do
  devise_for :users

  get '/init', to: 'home#init', as: 'init'
  get '/callback', to: 'home#callback', as: 'callback'
  get '/calendars', to: 'home#calendars', as: 'calendars'
  get '/events', to: 'home#events', as: 'events'
end
