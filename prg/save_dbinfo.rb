require 'yaml'
require 'active_record'
require 'rexml/document'

class SaveDbinfo
  
  def save(book_name)
    path = "../../books/" + book_name
    return if !(File.exists? path + '/index.xml')
    File.open(path + '/index.xml') do |f|
      @catalog_xml = f.read
    end
    @catalog = REXML::Document.new(@catalog_xml)
    
    @title =  @catalog.elements['/Ws/BookInfo/BookTitle'].text
    @author = @catalog.elements['/Ws/BookInfo/BookAuthor'].text
    @last_update = @catalog.elements['/Ws/BookInfo/BookUpdateTime'].text

    @book = Book.new
    if @book_name
      @book.bookname = @book_name
    else
      @book.bookname = @title
    end
    @book.bookinfo = @title
    @book.author = @author
    @book.save
    
    i = 0
    @catalog.elements.each('/Ws/ChapterList') do |ch|
      i += 1
      tit = ch.elements['ChapterTitle'].text
      fn = path + "/ch_" + ("%05d" % i) + '.txt'
      chapter = BookChapter.new
      chapter.chaptername = tit
      chapter.path = fn
      chapter.book_id = @book.id
      chapter.save
    end    
  end  
end

config = YAML::load(File.open('../../config/database.yml'))
ActiveRecord::Base.establish_connection(config['development'])
require '../app/models/book.rb'
require '../app/models/book_chapter.rb'

db = SaveDbinfo.new
Dir.open('../../public/books/').each do |dir|
  if !(/\.zip|\.txt|\.xml|\.|\.\.$/.match(dir))
    puts dir
    db.save(dir)
  end
end
