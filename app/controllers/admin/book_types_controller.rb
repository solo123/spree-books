class Admin::BookTypesController < Admin::BaseController
  resource_controller
  def addtype
  	book_type = BookType.find(params[:book_type_id])
  	book = Book.find_by_id(params[:book_id])
  	if !book
  		render :text => 'book not found.'
  	
  	elsif book_type.books.include? book
  		render :text => 'book already in book types.'
  	else
  		book_type.books << book
  		render :text => 'success to add into book types.'
  	end
  end
end