class ToolsController < Spree::BaseController
	def show
		if params
			s = ''
			params.each do |k, v|
				s << k.gsub(/>/, '&gt;').gsub(/</, '&lt;')
				s << ' = '
				s << v.gsub(/>/, '&gt;').gsub(/</, '&lt;')
				s << '<br />'
			end
			pd = PostedData.new
			pd.para = s
			pd.save!
			render :text => 'ok'
		end
	end
end