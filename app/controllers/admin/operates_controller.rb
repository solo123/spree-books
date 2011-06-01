class Admin::OperatesController < Admin::BaseController
	def index
		@operates = CmOperate.order('created_at desc').limit(100)
	end
	def dbglist
		@operates = CmDbOperate.order('created_at desc').limit(100)
	end
	def show
		@op = CmDbOperate.find(params[:id])
	end
end