class Admin::OperatesController < Admin::BaseController
	def index
		@operates = CmOperate.order('created_at desc').limit(100)
	end
	def dbglist
		@operates = CmDbOperate.order('created_at desc').limit(100)
	end
	def addop
		op = nil
		if params[:dbg]
			op = CmDbOperate.new
		else
			op = CmOperate.new
		end
		op.cm_user_id = params[:cm_user_id].to_i
		op.operate = params[:operate]
		op.result = params[:result]
		op.save
		render :text => 'ok'
	end
end