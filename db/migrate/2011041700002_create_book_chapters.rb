class CreateBookChapters < ActiveRecord::Migration
  def self.up
    create_table :book_chapters do |t|
    	t.integer :book_id
    	t.string :chaptername
    	t.integer :length
    	t.integer :page
    	t.text :content
    end
  end

  def self.down
    drop_table :book_chapters
  end
end