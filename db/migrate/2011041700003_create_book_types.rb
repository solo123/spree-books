class CreateBookTypes < ActiveRecord::Migration
  def self.up
    create_table :book_types do |t|
    	t.integer :parent_id
    	t.string :permalink
    	t.integer :counter_cache
    	t.integer :level_cache
    	
    	t.string :name
    	t.integer :created_by
	 	t.timestamps
    end
  end

  def self.down
    drop_table :book_types
  end
end