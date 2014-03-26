Flipbook::Application.routes.draw do
   
   get 'flipbks/:id/addphoto/' => 'photos#add'
   get '/photos' => 'photos#feed', :as => :feed
   resources :users, :flipbks, :logins, :photos
   
   match 'users/:id' => 'users#show'
   
   get 'profile/:id' => 'public#profile', :as => :profile

   get '/profile/' => 'public#profile'

   get '/oauth/connect' => 'users#connect'
   get '/oauth/callback' => 'users#callback'
   
   root :to => 'public#index'

end
