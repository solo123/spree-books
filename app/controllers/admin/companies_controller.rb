class Admin::CompaniesController < Admin::BaseController
  resource_controller
  def save_customer
  	u = Customer.find(params[:customer_id])
  	u.user_id = params[:user_id]
  	u.company_id = params[:id]
  	u.save!
  	render :text => 'ok'
  end
end