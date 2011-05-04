class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
    	t.integer :company_id
    	t.string :channel
    	t.string :title
    	t.string :description
    	t.integer :status, :default => 0
  	 	t.timestamps
    end
  end

  def self.down
    drop_table :channels
  end
end