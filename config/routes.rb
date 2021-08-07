Rails.application.routes.draw do
  #get 'home/top'
  get "/" => "home#top"
  get "about" => "home#about"
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
