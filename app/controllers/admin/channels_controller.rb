class Admin::ChannelsController < Admin::BaseController
  resource_controller
  
  index.before do
		@companies = Company.all
		@current = params[:company] ? params[:company].to_i : 0
  end
  
  def collection
  	if params[:company] && params[:company] != '0'
  		@object ||= end_of_association_chain.find_all_by_company_id(params[:company])
  	else
  		@object ||= end_of_association_chain.all
  	end
  end
end