class Reader::ActivetionController < Spree::BaseController
    def index  
      @centerNumber = params[:centerNumber]
      @channel = params[:channel]
      @client_id = params[:client_id]
        
      @num = @centerNumber[6,2]
      if @num == '00'
        
      else
        
      end
      
    end
end