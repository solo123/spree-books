class Reader::ActivetionController < Spree::BaseController
    def index  
   
      @channel = params[:channel]
      @client_id = params[:client_id]
     #根据client_id查找bk_clients表  
    @bk_clients = BkClient.fing(params[:client_id])
    @userid =  @bk_clients.user_id
    #把传送过来的渠道号加入用户表的渠道字段中
    CmUser.self.add_user(@userid, params[:channel])
      
      #创建一个xml 返回信息
      
    end
end
