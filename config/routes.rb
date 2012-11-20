TestItemx::Engine.routes.draw do

  #mount Authentify::Engine => "/authentify"  #, :as => "authentify_engine"

  resources :standards
  resources :test_items

  root :to => "test_items#index"
end
