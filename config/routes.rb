TestItemx::Engine.routes.draw do

  mount Authentify::Engine => "/authentify"  #, :as => "authentify_engine"
  mount Quotex::Engine => "/quotex"  #, :as => "authentify_engine"

  resources :standards
  resources :test_items
  resources :test_plan_logs
  resources :quotes do
    resources :test_itemx_test_plans
  end
  root :to => "test_items#index"
  


  resources :test_plans, :only => [:index]
  resources :quotes do
    collection do
      get 'search'
      put 'search_results'
      get 'stats'
      put 'stats_results'      
    end

    resources :test_plans
  end
 
  resources :test_plans do
    collection do
      get 'search'
      put 'search_results'
    end

    resources :test_samples, :only => [:show, :new, :create, :edit, :update, :destroy]
    resources :test_plan_logs
  end


  match '/view_handler', :to => 'application#view_handler'

end
