class Admin::ImportsController < Admin::BaseController
	def index
	  @balances = Balance.where('status=0')
	end

  def do_import
  	data = params[:import_text]
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
  	redirect_to :action => :index
  end
  
  def clear
  	Balance.where('status=0').delete_all
  	redirect_to :action => :index
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
  	redirect_to :action => :index
  end
  
  def show
    render :text => "show"
  end
end









