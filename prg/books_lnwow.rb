require 'iconv'
require 'open-uri'
require 'rexml/document'
require 'hpricot'

class BooksLnwow
  attr_accessor :title, :author, :last_update
  def initialize
    @base_url = 'http://www.lnwow.com'
    @book_path = '../../public/books/'
  end

  def search(book_name)
    result = []
    url = @base_url + "/Book/Search.aspx?searchclass=1&searchkey=" + URI.escape(Iconv.conv('gb2312//IGNORE', 'utf-8', book_name))
    f = open(url)
    doc = Hpricot(Iconv.conv('utf-8//IGNORE', f.charset, f.readlines.join("\n")))
    titles = doc / 'div#CListTitle'
    titles.each do |tit|
      lnk = (tit / 'a')[0]
      result << [lnk.inner_text, lnk.get_attribute("href") ]
    end
    @book_name = book_name
    result
  end
  
  def get_bookid(book_path)
    a = /\/(\d+)\//.match(book_path)
    if a
      a[1]
    else
      ''
    end
  end

  def read_book(book_id)
    url = @base_url + '/Book/' + book_id + '/Xml.html'
    f = open(url)
    @catalog_xml = f.read
    @catalog = REXML::Document.new(@catalog_xml)
    @title =  @catalog.elements['/Ws/BookInfo/BookTitle'].text
    @author = @catalog.elements['/Ws/BookInfo/BookAuthor'].text
    @last_update = @catalog.elements['/Ws/BookInfo/BookUpdateTime'].text
  end
  
  def create_book_content
    @book_name ||= @title
    return if !@book_name
    
    path = @book_path + @book_name
    Dir.mkdir(path) if !(File.directory? path)
    File.open(path + "/index.xml", 'w') { |f| f.write(@catalog_xml) }
    
    i = 0
    @catalog.elements.each('/Ws/ChapterList') do |ch|
      #break if i > 3
      i += 1
      tit = ch.elements['ChapterTitle'].text
      url = ch.elements['ChapterUrl'].text
      url = @base_url + '/' + url.slice(1,200)
      f = open(url)
      data = Iconv.conv('utf-8//IGNORE', 'gbk', f.readlines.join("\n"))
      doc = Hpricot(data)
      div = doc / 'div.nr_wz'
      txt = div.inner_html.split("\n").join
      exp = /<p>(.*)<\/p>/.match(txt)
      txt = exp[1] if exp
      exp = /(.*)<iframe/.match(txt)
      txt = exp[1] if exp
      txt = txt.split("<br /><br />").join("\n")
      
      fn = path + "/ch_" + ("%05d" % i) + '.txt'
      puts fn
      File.open(fn, 'w') do |f_ch|
        f_ch.write(txt)
      end
    end
  end
  
end
