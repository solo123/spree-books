class Admin::ChartsController < Admin::BaseController
	def index
		@balances = Balance.find_by_sql ["select balance_date, sum(count) as cnt from balances group by balance_date"]
		@total_count=0
		@companies = Company.find_by_sql "select id,name from companies"
		s = []
		c = []
		@query_data = []
		@balances.each do |b|
			@total_count += b.cnt.to_i
			s << "[#{b.balance_date.to_i * 1000}, #{b.cnt.to_i}]"
		end
		@query_data << s.join(',')
	end
	# => view视图请求controll
	def create(com)
		# => 接受form表单参数   对其参数进行判断是否为nil || 其length>0
		@companies = Balance.find_by_sql ["select sum(count) as count from balances where company_id in (select id from companies where name in ? )group by company_id","#{com.name.to_s}"]
		n = []
		@query_data = []
		@balances.each do |b|
			@total_count += b.cnt.to_i
			n << ", #{b.cnt.to_i}]"
		end
		@query_data << n.join(',')
		render :index
	end
	
	def create
		@channels = Balance.find_by_sql ["select sum(count) as count,channel from balances where channel=? group by channel","0310%"]
	end
end