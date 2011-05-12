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
				@chapter = BookChapter.find(:first, :conditions => ["book_id=? and chapterorder=?", params[:id], params[:ch]])
			else
				BookChapter.find_all_by_book_id(params[:id]).each_with_index do |b, idx|
					b.chapterorder = idx + 1
					b.save
				end
				@chapter = @book.book_chapters.order('chapterorder').first
			end
			if @chapter && @chapter.content
				@texts = @chapter.content.split "\n"
			else
				@texts = []
			end
			@prev_ch = @chapter.chapterorder > 1 ? "books/#{@chapter.book_id}/chapter/#{@chapter.chapterorder - 1}" : "CMD_ALERT 已经是第一章"
			@next_ch = @chapter.chapterorder < @book.book_chapters.count ? "books/#{@chapter.book_id}/chapter/#{@chapter.chapterorder + 1}" : "CMD_ALERT 已经是最后一章"

			render 'book_chapter.xml.erb'
		else
			render 'book_cover.xml.erb'
		end
	end
end