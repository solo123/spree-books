class Admin::ChartsController < Admin::BaseController
  def index
  	@balances = Balance.find_by_sql ["select  balance_date, sum(count) as cnt from balances group by balance_date"]
  	s = []
	 	@total_count=0
	 	@balances.each do |b|
	 		@total_count += b.cnt.to_i 
	 		s << "[#{b.balance_date.to_i * 1000}, #{b.cnt.to_i}]"
	  end
	  @query_data = []
	  @query_data << s.join(',')
  end
end