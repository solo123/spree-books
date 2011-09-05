require 'open-uri'
require 'hpricot'



class BookReader17k
  def initialize(book_number)
    @book_number = book_number
    @book_path = "../public/books/"
  end
  def read_book
    url_cover = "http://www.17k.com/#{@book_number}.html"
    url_catalog = "http://www.17k.com/list/#{@book_number}.html"
    doc_cat = Hpricot(open(url_catalog))
    create_book_catalog(doc_cat)
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

  def create_book_content
    return if !@title
    
    path = @book_path + @title
    return if !(File.directory? path)

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
  
end