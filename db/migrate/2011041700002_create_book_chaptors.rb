class CreateBookChaptors < ActiveRecord::Migration
  def self.up
    create_table :book_chaptors do |t|
    	t.integer :book_id
    	t.string :chaptorname
    	t.integer :length
    	t.integer :page
    	t.text :content
    end
  end

  def self.down
    drop_table :book_chaptors
  end
end