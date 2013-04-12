Opensrs::Application.routes.draw do
  get "welcome/index"
  match 'opensrs' => 'opensrs#index', :via => :post
  root :to => 'welcome#index'
end
