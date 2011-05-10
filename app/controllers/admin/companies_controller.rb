class Admin::CompaniesController < Admin::BaseController
  resource_controller
  def save_customer
  	u = Customer.find(params[:customer_id])
  	u.user_id = params[:user_id]
  	u.company_id = params[:id]
  	u.save!
  	render :text => 'ok'
  end
  
  update.after do
  	cmp = Company.find(params[:id])
  	cmp.channels.clear
  	if params[:channels]
	  	params[:channels].each do |ch_id, b|
	  		cmp.channels << Channel.find(ch_id)
	  	end
  	end
  	txt_chs = params[:chs]
  	if txt_chs
  		txt_chs.split(',').each do |txt_ch|
  			if txt_ch && txt_ch.length>1
  				ch = Channel.find_by_channel(txt_ch)
  				if !ch
  					ch = Channel.new
  					ch.channel = txt_ch
  					ch.save!
  				end
					cmp.channels << ch
  			end
  		end
  	end
  end
  create.after do
  	if params[:chs]
  		params[:chs].split(',').each do |ch|
  			c = Channel.new
  			c.company_id = object.id
  			c.channel = ch
  			c.save!
  		end
  	end
  end
end