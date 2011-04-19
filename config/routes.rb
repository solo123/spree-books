Rails.application.routes.draw do
  match '/visit' => 'home#list'
  match '/vamp/mtkbook/details.aspx' => 'books#details'
  match 'cminterface/sms/sync.aspx' => 'books#sync'
  match '/resource/books/cover/:id.:format' => 'book_covers#show'
  match '/resource/books/cover/' => 'book_covers#show'
  
  namespace :admin do
    resources :books
    resources :book_chapters
    resources :book_types do
    	match 'add' => 'book_types#addtype'
    end
    resources :book_clients
  end
end
