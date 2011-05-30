class CreateCmLogins < ActiveRecord::Migration
  def self.up
    create_table :cm_logins do |t|
    	t.integer :cm_user_id
    	t.string :channel
    	t.string :userid
    	t.string :sms_center
    	t.string :imsi
    	t.string :imei
    	t.string :interface
    	t.string :version
  	 	t.timestamps
    end
    create_table :cm_users do |t|
    	t.string :userid
    	t.string :channel
    	t.string :remark
    	t.timestamps
    end
  end

  def self.down
    drop_table :cm_logins
    drop_table :cm_users
  end
end