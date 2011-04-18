Rails.application.routes.draw do
  match '/visit' => 'home#list'
  match '/vamp/mtkbook/details.aspx' => 'books#details'
  match 'cminterface/sms/sync.aspx' => 'demo#sync'
  
  namespace :admin do
    resources :books
    resources :book_chaptors
    resources :book_types
  end
end
