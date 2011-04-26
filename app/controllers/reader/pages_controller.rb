class Reader::PagesController < Spree::BaseController
	respond_to :xml
	def home
		render 'home.xml.erb' 
	end
	def history
		render 'history.xml.erb'
	end
	def hot_books
		render 'hot_books.xml.erb'
	end
	def paid_books
		render 'history.xml.erb'
	end
	def favorite
		render 'history.xml.erb'
	end
	def setting
		render 'history.xml.erb'
	end
	def search
		render 'history.xml.erb'
	end
	def books
		op = params[:op]
		@book = Book.find(params[:id])
		if op == 'catalog'
			render 'book_catalog.xml.erb'
		elsif op == 'chapter'
			if params[:ch]
				@chapter = BookChapter.find(params[:ch])
			else
				@chapter = @book.book_chapters.first
			end
			render 'book_chapter.xml.erb'
		else
			render 'book_cover.xml.erb'
		end
	end
end