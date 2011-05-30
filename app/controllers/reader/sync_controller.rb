class Reader::SyncController < Spree::BaseController
	respond_to :xml
	def info
		p = ProductUsage.new
		p.channel = params[:channel]
		p.center = params[:center]
		p.imsi = params[:imsi]
		p.name = params[:name]
		p.version = params[:version]
		p.save!
		
		s = ''
		params.each do |k, v|
			s << "<b>#{k}</b> = "
			s << v.gsub(/>/, '&gt;').gsub(/</, '&lt;')
			s << '<br />'
		end
		pd = PostedData.new
		pd.para = s
		pd.save!
		
		@prefs = Preference.where('owner_id=2').all
		render 'info.xml.erb'
	end
	def tck
		render :text => 'tck ok.'
	end
	def login
		lg = CmLogin.new
		lg.channel = params[:channel]
		lg.userid = params[:userid]
		lg.sms_center = params[:sms_cnter]
		lg.imsi = params[:imsi]
		lg.imei = params[:imei]
		lg.interface = params[:interface]
		lg.version = params[:version]
		lg.save
		render 'login.txt.erb', :layout => false
	end

end