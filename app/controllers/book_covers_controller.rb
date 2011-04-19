class BookCoversController < Spree::BaseController
	def show
		f = "#{RAILS_ROOT}/public/images/book_covers/#{params[:id]}.#{params[:format]}"
		f = "#{RAILS_ROOT}/public/images/book_covers/0.jpg" if !File.exist? f
		send_file f, :type => 'image/jpeg', :disposition => 'inline'
	end
end