Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pull_requests#index'

  resource :pull_requests, :only => [:index]
  get '/pull_requests' => 'pull_requests#index'

  resource :comments, :only => [:index]
  get '/comments' => 'comments#index'

  post '/payload' do
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
  end
end
