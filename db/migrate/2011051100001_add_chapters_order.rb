class AddChaptersOrder < ActiveRecord::Migration
  def self.up
  	add_column :book_chapters, :chapterorder, :integer, :default => 0
  end

  def self.down
    remove_column :book_chapters, :chapterorder
  end
end