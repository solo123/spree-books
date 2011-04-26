class Reader::PagesController < Spree::BaseController
	def index
		render 'index.xml.erb' 
	end
end