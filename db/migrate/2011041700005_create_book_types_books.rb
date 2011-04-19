class CreateBookTypesBooks < ActiveRecord::Migration
  def self.up
    create_table :book_types_books, :id => false do |t|
    	t.integer :book_id
    	t.integer :book_type_id
    end
  end

  def self.down
    drop_table :book_types_books
  end
end