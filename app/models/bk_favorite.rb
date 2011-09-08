class BkFavorite < ActiveRecord::Base
  
 def self.add_favorite(cl_id,booksid)
    f = BkFavorite.new
    f.client_id = cl_id
    f.book_id = booksid
    f.save
  end
  
end
