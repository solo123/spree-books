Rails.application.routes.draw do
  match '/visit' => 'home#list'
  match '/vamp/mtkbook/details.aspx' => 'books#details'
  match 'cminterface/sms/sync.aspx' => 'demo#sync'
  
  namespace :admin do
    resources :books do
    	match 'chaptor' => 'book_chaptors#new'
    end
    resources :book_chaptors
    resources :book_types do
    	match 'add' => 'book_types#addtype'
    end
  end
end
