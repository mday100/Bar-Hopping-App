Rails.application.routes.draw do

root :to => 'users#index'

resources :locations do
	resources :comments
end

resources :user_sessions
resources :users

get 'login' => 'user_sessions#new', :as => :login
post 'logout' => 'user_sessions#destroy', :as => :logout
post 'vote/:id' => 'comments#vote', :as => :vote 

end
