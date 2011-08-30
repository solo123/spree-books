# encoding: utf-8
class Reader::PagesController < Spree::BaseController
	respond_to :html, :xml
	def home

    @booksid = nil
    if params[:client_id]
       client = BkClient.find(params[:client_id])
       last_read = BkHistory.where(['client_id=?',params[:client_id]]).order('created_at desc').first;
       if last_read
         @booksid = last_read.book_id
         @chid = last_read.chapter_id
       end
    end  


	  if params[:client_id]
	    @bk_client = BkClient.find(params[:client_id])
	  else
      @bk_client = BkClient.where( ['user_id=? or imsi=? or imei=?', params[:user_id], params[:imsi], params[:imei]]).first
      if !@bk_client
        @bk_client = BkClient.new(:user_id => params[:user_id], :imsi => params[:imsi], :imei => params[:imei] )
        @bk_client.show_name = params[:show_name]
        @bk_client.mobile_type = params[:mobile_type]
        @bk_client.screen_width = params[:screen_width]
        @bk_client.screen_height = params[:screen_height]
        @bk_client.save
      end
	  end
		render 'home.xml.erb' 
	end
	def search_page
		
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
		render 'link.xml.erb'
	end
	def history
	  @histories = BkHistory.where(params[:client_id]);
		render 'history.xml.erb'
	end
	def hot_books
		render 'hot_books.xml.erb'
	end
	def paid_books
		render 'history.xml.erb'
	end
	def favorite
	   @favorites = BkFavorite.where(params[:client_id]);
		render 'favorite.xml.erb'
	end
	def setting
		render 'history.xml.erb'
	end
	
	def search
	  iconv = Iconv.new "utf-8//IGNORE", "GBK"
	  @books = nil 
	  if params[:s]    
       @books = Book.where(['bookname || author like ?', "%#{iconv.iconv(params[:s])}%"]).order('bookname').limit(200)
	  end
	  render 'books.xml.erb'
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