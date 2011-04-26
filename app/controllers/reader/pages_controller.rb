class Reader::PagesController < Spree::BaseController
	def home
		render 'home.xml.erb' 
	end
	def history
		render 'history.xml.erb'
	end
end