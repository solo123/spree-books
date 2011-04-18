class DemoController < ApplicationController
	respond_to :html, :xml 
	def details
		if params[:p]
			if params[:p] == 'simplebooktype'
				render 'book_list_brief.xml.erb'
			elsif params[:p] == 'booktypeinfo'
				render 'book_types.xml.erb'
			elsif ['topbook', 'changxiao', 'bestbook', 'GoodClassisTuijian', 'goodbook', 'classisbook', 'tuijianbook'].include? params[:p]
				render 'book_top.xml.erb'
			else
				render 'book_list.xml.erb'
			end
		elsif params[:bookid]
			render 'book_detail.xml.erb'
		elsif params[:bookchapterid]
			render 'book_chapter.xml.erb'
		elsif params[:booktypeid]
			render 'book_type.xml.erb'
		elsif params[:chapterid] && params[:page]
			render 'book_content.text.erb'
		elsif params[:sbookName]
			render 'book_search.xml.erb'
		end
	end
	def sync
		render 'sync.xml.erb'
	end
end