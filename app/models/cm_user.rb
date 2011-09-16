class CmUser < ActiveRecord::Base
   def self.add_user(userid, channel)
    u = CmUser.new
    u.userid = userid
    u.channel = channel
    u.save
  end
end
