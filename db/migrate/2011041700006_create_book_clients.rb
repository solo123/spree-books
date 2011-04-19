class CreateBookClients < ActiveRecord::Migration
  def self.up
    create_table :book_clients do |t|
    	t.string :channel
    	t.string :number
    	t.string :center
    	t.string :imsi
    	t.string :name
    	t.string :version
    	t.text :http_header
    	t.timestamps
    end
  end

  def self.down
    drop_table :book_clients
  end
end