class Reader::PagesController < Spree::BaseController
	def home
		render 'home.xml.erb' 
	end
	def history
		render 'history.xml.erb'
	end
	def books
		op = params[:op]
		if op == 'catalog'
			render 'book_catalog.xml.erb'
		elsif op == 'chapter'
			render 'book_chapter.xml.erb'
		else
			render 'book_cover.xml.erb'
		end
	end
end