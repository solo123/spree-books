class AddBookFields < ActiveRecord::Migration
  def self.up
  	add_column :books, :author_id, :integer
  	add_column :book_chapters, :path, :string
  end

  def self.down
    remove_column :books, :author_id
    remove_column :book_chapters, :path
  end
end