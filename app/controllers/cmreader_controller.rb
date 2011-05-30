class CmreaderController < ApplicationController
	def baseconfig
		render 'base_config.txt', :layout => false
	end
end