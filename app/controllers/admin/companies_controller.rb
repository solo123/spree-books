class Admin::CompaniesController < Admin::BaseController
  resource_controller
  def save_customer
  	u = Customer.find(params[:customer_id])
  	u.user_id = params[:user_id]
  	u.company_id = params[:id]
  	u.save!
  	render :text => 'ok'
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