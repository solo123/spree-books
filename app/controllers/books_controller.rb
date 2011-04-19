class BooksController < Spree::BaseController
	respond_to :html, :xml
	def details
		if params[:p]
			p = BookType.find_by_permalink('booktype')
			@book_types = BookType.where('parent_id=?', p.id)
			if params[:p] == 'simplebooktype'
				render 'book_types.xml.erb'
			elsif ['booktypeinfo', 'changxiao', 'BestTopChangXiao', 'bestbook', 'goodbook', 'GoodClassisTuijian', 'tuijianbook', 'classisbook'].include? params[:p]
				@types_num, @books_num = 6, 5
				@types_num, @books_num = 12, 2 if params[:p] == 'booktypeinfo'
				@types_num = 3 if params[:p] == 'BestTopChangXiao'
				render 'book_types_info.xml.erb'
			elsif params[:p] == 'booktypeinfo'
				render 'book_types_info.xml.erb'
			elsif params[:p] == 'topbook'
				render 'book_top.xml.erb'
			elsif params[:p] == 'changxiao'
				render 'book_types_info_top_sale.xml.erb'
			elsif params[:p] == 'BestTopChangXiao'
				render 'book_types_info_top_sale.xml.erb'
			end

		elsif params[:bookid]
			render 'book_detail.xml.erb'	
		elsif params[:bookchapterid]
			render 'book_chapter.xml.erb'
		elsif params[:booktypeid]
			tp = BookType.find_by_id(params[:booktypeid])
			@books = []
			@books = tp.books if tp
			render 'books.xml.erb'
		elsif params[:chapterid] && params[:page]
			ch = BookChapter.find(params[:chapterid])
			render :text => ch.content	
		elsif params[:sbookName]
			@books = Book.where('bookname like \'%' + params[:sbookName] + '%\'')
			render 'book_search.xml.erb'
		end
	end
end