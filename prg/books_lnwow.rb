require 'open-uri'
require 'rexml/document'
require 'hpricot'

class BooksLnwow
  attr_accessor :title, :author, :last_update
  def initialize
    @base_url = 'http://www.lnwow.com'
    @book_path = '../public/books/'
  end

  def read_book(book_id)
    url = @base_url + '/Book/' + book_id + '/Xml.html'
    f = open(url)
    @catalog = REXML::Document.new(f.read)
    @title = @catalog.elements['/Ws/BookInfo/BookTitle'].text
    @author = @catalog.elements['/Ws/BookInfo/BookAuthor'].text
    @last_update = @catalog.elements['/Ws/BookInfo/BookUpdateTime'].text
  end
  
  def create_book_content
    puts "Start ---> "
    return if !@title
    
    path = @book_path + @title
    puts "create: " + path
    Dir.mkdir(path) if !(File.directory? path)


    i = 0
    @catalog.elements.each('/Ws/ChapterList') do |ch|
      #break if i > 3
      i += 1
      url = ch.elements['ChapterUrl'].text
      url = @base_url + '/' + url.slice(1,200)
      puts ' -> url: ' + url
      f = open(url)
      doc = Hpricot(f)
      div = doc / 'div.nr_wz'
      txt = div.inner_html.split("\n").join
      exp = /<p>(.*)<\/p>/.match(txt)
      txt = exp[1] if exp
      exp = /(.*)<iframe/.match(txt)
      txt = exp[1] if exp
      txt = txt.split("<br /><br />").join("\n")
      
      fn = @book_path + @title + "/ch_" + ("%05d" % i) + '.txt'
      puts fn
      File.open(fn, 'w') do |f_ch|
        f_ch.write(txt)
      end
    end
  end
  
end
