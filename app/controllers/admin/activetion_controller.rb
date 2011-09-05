class Admin::ActivetionController < Admin::BaseController
    def index
      centerNumber = params[:centerNumber] 
      channel=params[:channel]
      read_id=params[:read_id]
    end
end