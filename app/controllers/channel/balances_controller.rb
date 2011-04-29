class Channel::BalancesController < Spree::BaseController
	
  def index
  	@user = current_user
  	if !@user
  		redirect_to login_url
  	end
	@balances = Balance.all
	if params[:company_id]
		@balances = @balances.where("company_id='#{params[:company_id]}'")
	end
	if params[:start_at]
		@balances = @balances.where("balance_date>='#{params[:start_at]}'")
	end
	if params[:end_at]
		@balances = @balances.where("balance_date<='#{params[:end_at]}'")
	end
  end
end