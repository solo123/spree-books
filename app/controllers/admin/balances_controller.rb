class Admin::BalancesController < Admin::BaseController
  def new
  	@balances = Balance.where('status=0')
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
  end
end









