class Admin::BalancesController < Admin::BaseController
	def index
	end
  def new
  	@balances = Balance.where('status=0')
  	render :action => :new, :layout => !request.xhr?
  end
  
  def query
 		@companies = Company.all
  	@balances = Balance.where('status=1')
  	if params[:company] && params[:company] > '0'
  		@balances = @balances.where('company_id=' + params[:company])
  	end
  	if params[:from] && params[:from].length > 1
			@balances = @balances.where("balance_date>='#{params[:from]}'")
		end
		if params[:to] && params[:to].length > 1
			@balances = @balances.where("balance_date<='#{params[:to]}'")
		end
  	@current = params[:company] ? params[:company].to_i : 0
  	render :layout => !request.xhr?
  end
  def imp
  	render 'imp.html.erb', :layout => !request.xhr?
  end
  def import
  	data = params[:data]
  	lines = data.split(/\n/)
  	t = "result:\n"
  	lines.each do |line|
  		cs = line.split(/[\t\s]/)
  		if cs.length>2
  			b = Balance.new
  			b.product_id = 1
  			b.balance_date = cs[0]
  			b.channel = cs[1]
  			b.count = cs[2]
  			b.status = 0
  			b.save!
  		end
  	end
  	render :text => 'ok'
  end
  
  def clear
  	Balance.where('status=0').delete_all
  	render :text => 'ok'
  end
  def save
  	Balance.where('status=0').each do |b|
  		ch = Channel.find_by_channel(b.channel)
  		if ch
  			b.company_id = ch.company_id
  			b.status = 1
  			b.save!
  		end
    end
  	render :text => 'ok'
  end
end









