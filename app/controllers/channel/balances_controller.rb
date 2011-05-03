class Channel::BalancesController < Spree::BaseController
	
  def index
  	@user = current_user
  	if !@user
  		redirect_to login_url
  	end
  	
  	customer = Customer.find_all_by_user_id(@user.id)
  	@balances = nil
  	if customer.length > 0
  		company = customer[0].company
  		if company
  			@balances = Balance.find_all_by_company_id(company.id)
  		end
  	end
	if params[:start_at]
		@balances = @balances.where("balance_date>='#{params[:start_at]}'")
	end
	if params[:end_at]
		@balances = @balances.where("balance_date<='#{params[:end_at]}'")
	end
  end
end