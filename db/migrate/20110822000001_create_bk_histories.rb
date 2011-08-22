class CreateBkHistories < ActiveRecord::Migration
  def self.up
    create_table :bk_histories do |t|
    	t.integer :reader_id
    	t.integer :book_id
    	t.integer :chapter_id 
    end
    
     create_table :bk_hotsites do |t|
      t.string :hot_book_name
      t.string :hot_book_url
      t.integer :hot_book_state
    end
    
     create_table :bk_toplists do |t|
      t.integer :hot_booksite_id
      t.string :book_name
      t.integer :book_order_num
    end
    
      create_table :bk_favorites do |t|
      t.integer :book_id
      t.datetime :fovorite_time
    end
  end

  def self.down
    drop_table :bk_histories
    drop_table :bk_hot_hotsites
    drop_table :bk_toplists
    drop_table :bk_favorites
  end

end