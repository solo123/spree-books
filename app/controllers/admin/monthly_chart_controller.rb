class Admin::MonthlyChartController < Admin::BaseController
  def index
  	@balances = Balance.find_by_sql ["select  balance_date, sum(count) as cnt from balances group by balance_date"]
  end
end