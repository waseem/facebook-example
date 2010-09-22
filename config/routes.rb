ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resource :facebook_session

  map.root :controller => 'sessions', :action => 'new'
end
