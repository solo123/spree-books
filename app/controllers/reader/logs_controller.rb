class Reader::LogsController < Spree::BaseController
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
		op.url = params[:url]
		op.request_header = params[:request_header]
		op.response_header = params[:response_header]
		op.save
		render :text => 'ok'
	end
end