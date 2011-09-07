require 'iconv'
require 'open-uri'
require 'hpricot'
require 'rexml/document'

class BookReaderLnwow
  attr_accessor :book_name, :title, :author, :last_update
  def initialize
    @book_path = "../public/books/"
    @base_url  = "http://www.lnwow.com"
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
    @title = nil
    @author = nil
    @last_update = nil
    
    url = @base_url + "/Book/" + book_id + "/Xml.html"
    f = open(url)
    xml_data = f.read
    @catalog = REXML::Document.new(xml_data)
    return if !@catalog

    @title = @catalog.elements['/Ws/BookInfo/BookTitle'].text    
    @author = @catalog.elements['/Ws/BookInfo/BookAuthor'].text
    @last_update = @catalog.elements['/Ws/BookInfo/BookUpdateTime'].text
  end
  
  def create_book_content
    return if !@title
    
    path = @book_path + @title
    return if !(File.directory? path)

    @catalog.elements['/Ws/ChapterList'].each do |ch|
      
    end

    File.open("#{path}/index.txt") do |f|
      f.each_line do |line|
        ss = line.split "\t"
        if ss.count == 4
          chs = ss[0].to_i
          url = ss[3]
          fn = "#{path}/ch#{'%03d' % chs}.txt"
          if !(File.exist? fn)
            doc = Hpricot(open("http://www.17k.com#{url}"))
            content = doc / '#chapterContent'
            cs = content.inner_html.split('<br /><br />')
            File.open(fn, 'w') do |f_ch|
              f_ch.write(cs.join("\n").strip)
            end
          end
        end
      end
    end
  end

  def create_book_catalog(doc)
    @title = (doc / '.directory_title h1').text
    path = @book_path + @title
    Dir.mkdir path if !(File.directory? path)
    File.open(path << '/index.txt', 'w') do |f|
      chs = 0
      content = doc / '.directory .directory_con div'
      content.each do |div|
        if (div.get_attribute('class') == 'tit')
          f.puts "sub_title\t#{(div/'h2').text}"
        else
        (div/'ul li').each do |li|
            link = (li/'a')
            f.puts "#{chs}\tchapter\t#{link.text}\t#{link.attr('href')}"
            chs += 1
          end
        end
      end
    end
  end


  
end