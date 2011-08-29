class BkHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :book_chapter
end
