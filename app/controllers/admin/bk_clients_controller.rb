class Admin::BkClientsController < Admin::BaseController
  def destroy
    @bk_client = BkClient.find(params[:id])
    @bk_client.destroy

    respond_to do |format|
      format.html { redirect_to(admin_bk_clients_path) }
      format.xml  { head :ok }
    end
  end
end