class Admin::BalancesController < Admin::ResourceController
  private
  def collection
    return @collection if @collection.present?
    
    pagination_options = { :per_page  => 200,
                           :page      => params[:page]}
                            
    @search = Balance.search(params[:search])
    @collection = @search.paginate(pagination_options)
  end  
end









