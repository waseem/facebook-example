ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resources :facebook_friends
  map.resources :facebook_albums

  map.root :controller => 'sessions', :action => 'new'
end
