class Channel::BalancesController < Spree::BaseController
	def index
		@user = current_user
		if !@user
			session["user_return_to"] = "/"
			#session[:return_to] = "/"
			redirect_to login_url
			return
		end

		customer = Customer.find_all_by_user_id(@user.id)
		@balances = nil
		@company = nil

		if @user.has_role? 'admin'
			if !params[:company]
				redirect_to '/admin' 
				return
			end
			@company = Company.find(params[:company])
		elsif customer.length > 0
			@company = customer[0].company
		end
		if @company
			@balances = Balance.find_all_by_company_id(@company.id)
		end
		if params[:start_at]
			@balances = @balances.where("balance_date>='#{params[:start_at]}'")
		end
		if params[:end_at]
			@balances = @balances.where("balance_date<='#{params[:end_at]}'")
		end
	end
end