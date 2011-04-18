class Book < ActiveRecord::Base
	has_and_belongs_to_many :book_types
end
