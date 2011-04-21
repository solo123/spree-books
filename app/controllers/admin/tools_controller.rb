class Admin::ToolsController < Admin::BaseController
	def index
		@posted_datas = PostedData.order('created_at desc').limit(100)
	end
end