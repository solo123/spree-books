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
	

	def create
		@companies = Balance.find_by_sql ["select sum(count) as count from balances where company_id in (select id from companies where name in ? )group by company_id","#{company_name}"]
		n = []
		@query_data = []
		@balances.each do |b|
			@total_count += b.cnt.to_i
			n << ", #{b.cnt.to_i}]"
		end
		@query_data << n.join(',')
		render :index
 end
 

	# => 对于根据公司名的查询

	def query_name
		n =[]
		company_name = name
		
		if @companies == nil
		return nil;
		else
			@companies.each do |com|
				n << "[,#{com.count}]"
			end
		end
		@query_data << n.join(',')
	end
end