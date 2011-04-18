class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
    	t.string :bookname
    	t.string :author
    	t.text   :bookinfo
    	t.integer :rank
    	t.integer :hot
    	t.integer :views
    	t.string :picurl
    	t.integer :status, :default => 0
	 	t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end