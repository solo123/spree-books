# encoding: utf-8
class Reader::PagesController < Spree::BaseController
	respond_to :html, :xml
	def home
		render 'home.xml.erb' 
	end
	def search_page
		@title = '搜索结果'
		@books = Book.where('bookname + " " + author like "%' + params[:s] + '%"').order('bookname').limit(200)
		render 'books.xml.erb'
	end
	def config_page
		render 'config.xml.erb'
	end
	def help_page
		render 'help.xml.erb'
	end
	def upgrade_page
		render 'upgrade.xml.erb'
	end
	def menu
		@book = Book.find_by_status(99);
		@chapter = @book.book_chapters if @book
		render 'links.xml.erb'
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
			if @chapter.content
				@texts = @chapter.content.split "\n"
			else
				@texts = []
			end
			render 'book_chapter.xml.erb'
		else
			render 'book_cover.xml.erb'
		end
	end
end