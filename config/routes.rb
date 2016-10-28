Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pull_requests#index'

  resource :pull_requests, :only => [:index]
  get '/pull_requests' => 'pull_requests#index'

  resource :comments, :only => [:index]
  get '/comments' => 'comments#index'
end
