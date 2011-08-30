class CreateBkClients < ActiveRecord::Migration
  def self.up
    create_table :bk_clients do |t|
    	t.string :show_name
    	t.integer :user_id
    	t.integer :imsi
    	t.integer :imei
    	t.string :timestamp
    	t.string :mobile_type
    	t.string :screen_width
    	t.string :screen_height
    end
  end

  def self.down
    drop_table :bk_clients
  end

end