class Admin::ChartsController < Admin::BaseController
	def index
		@total_count=0
		s = []
		c = []
		@query_data = []
		bs = Balance.find_by_sql "select balance_date, sum(count) as cnt from balances group by balance_date"
		bs.each do |b|
			@total_count += b.cnt.to_i
			s << "[#{b.balance_date.to_i * 1000}, #{b.cnt.to_i}]"
		end
		@query_data << s.join(',')
		sql = <<EOF
select  companies.id, company_id,   sum(count) as cnt , name
from balances
join companies on balances.company_id=companies.id
group by company_id
order by cnt desc limit 10
EOF
		@companies = Company.find_by_sql sql 
	end
<<<<<<< HEAD
	# => view视图请求controll
	def create(com)
		# => 接受form表单参数   对其参数进行判断是否为nil || 其length>0
		@companies = Balance.find_by_sql ["select sum(count) as count from balances where company_id in (select id from companies where name in ? )group by company_id","#{com.name.to_s}"]
		n = []
=======
	

	def create
		@total_count=0
		s = []
		c = []
>>>>>>> 73b56cc5ccb1d0083bc4abebbc18a2565742987c
		@query_data = []
		bs = Balance.find_by_sql "select balance_date, sum(count) as cnt from balances group by balance_date"
		bs.each do |b|
			@total_count += b.cnt.to_i
			s << "[#{b.balance_date.to_i * 1000}, #{b.cnt.to_i}]"
		end
		@query_data << s.join(',')


	  if params[:company]
	  	s = []
	  	params[:company].each do |p,v|
				s = []
				bs = Balance.find_by_sql ["select balance_date, sum(count) as cnt from balances where company_id = ? group by balance_date", p]
				bs.each do |b|
					s << "[#{b.balance_date.to_i * 1000}, #{b.cnt.to_i}]"
				end
				@query_data << s.join(',')
	  	end
	  end		
		
		
		
		sql = <<EOF
select  companies.id, company_id,   sum(count) as cnt , name
from balances
join companies on balances.company_id=companies.id
group by company_id
order by cnt desc limit 10
EOF
		@companies = Company.find_by_sql sql
		
		
		
		
		
		render :index
	end
	
	def create
		@channels = Balance.find_by_sql ["select sum(count) as count,channel from balances where channel=? group by channel","0310%"]
	end
end