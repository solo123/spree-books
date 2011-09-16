class Reader::ActivetionController < ApplicationController
    def index  
      @channel = params[:channel] 
      @bk_clients = BkClient.fing(params[:client_id])  
      #把传送过来的渠道号加入用户表的渠道字段中
      @bk_clients.update_attributes(:channel => params[:channel]) 
      render 'index.xml.erb'     
    end
    
    def active_count
      #把激活次数加1
       @bkc = BkClient.fing(params[:client_id])
       @bkc.update_attributes(:active_count => (@bkc.active_count + 1)) 
    end
end
 
