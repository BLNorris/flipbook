Flipbook::Application.routes.draw do
   
   get 'flipbks/:id/addphoto/' => 'photos#add'
   get '/photos' => 'photos#feed', :as => :feed
   resources :users, :flipbks, :logins, :photos
   
   get 'profile/:id' => 'public#profile'

   get '/profile' => 'public#profile'

   get '/oauth/connect' => 'users#connect'
   get '/oauth/callback' => 'users#callback'
   
   root :to => 'public#index'

end
