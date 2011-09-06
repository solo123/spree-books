class BkLog < ActiveRecord::Base
  belongs_to :book
  belongs_to :book_chapter
  belongs_to :bk_client, :foreign_key => 'client_id' 
  
  def self.add_history(client_id, book_id, chapter_id)
    log = BkLog.new
    log.client_id = client_id
    log.book_id = book_id
    log.chapter_id = chapter_id
    log.operate = 'read history'
    log.url = "/reader/pages/books/#{book_id}/chapters/#{chapter_id}"
    log.save
    
  end
end
