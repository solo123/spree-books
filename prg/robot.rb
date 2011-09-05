
require 'open-uri'
require 'hpricot'

class BookParser
  
end

class BookParser17k < BookParser
  
  def catalog
    iconv = Iconv.new('UTF-8//IGNORE', 'GBK')
    
    url = "http://www.17k.com/list/88532.html"
    doc = iconv.iconv open(url)    
    doc = Hpricot(doc)
    title = 
    
    book_title = ''
  end
    
end


