Rails.application.routes.draw do
  devise_for :users
  # No creation route just like Django version
  resources :questions, only: %i[index show]
  root 'questions#index'
  # get 'questions#result'
  get '/questions/:id/result', to: 'questions#result', as: 'result'
  post '/questions/:id/vote', to: 'questions#vote', as: 'vote'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
