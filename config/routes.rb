Rails.application.routes.draw do
  root 'questions#new'
  post '/questions', to: 'questions#create'
  get '/question/:token', to: 'questions#show'
  post '/question/answer', to: 'questions#answer'

  get '/statistical' , to: 'questions#get_statistical'
  post '/post-statistical', to: 'questions#post_statistical'
end
