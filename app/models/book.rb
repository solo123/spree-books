class Book < ActiveRecord::Base
	has_and_belongs_to_many :book_types
	has_many :book_chapters
	has_many :bk_histories
end
