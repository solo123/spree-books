class BkHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :book_chapter
  
  def self.add_history(client_id, book_id, chapter_id)
    h = BkHistory.new
    h.client_id = client_id
    h.book_id = book_id
    h.chapter_id = chapter_id
    h.save
  end
end
