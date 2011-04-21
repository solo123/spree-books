class ToolsController < Spree::BaseController
	def show
		if params
			s = ''
			params.each do |k, v|
				s << "<b>#{k}</b> = #{v}<br />"
			end
			pd = PostedData.new
			pd.para = s
			pd.save!
			render :text => 'ok'
		end
	end
end