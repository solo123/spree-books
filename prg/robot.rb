# encoding: utf-8

require './books_lnwow.rb'

class BookParser
  attr_accessor :book_list
  def book_list_file(filename)
    File.open("../../public/books/" + filename) do |f|
      @book_list = f.read.split("\n") 
    end
  end
  
  def run
    bk = BooksLnwow.new
    @book_list.each do |book_name|
      result = bk.search(book_name)
      puts "\n >>查找图书：[" + book_name + "]"
      s = select_result(result)
      if s > 0
        r = result[s-1]
        puts r
        book_id = bk.get_bookid(r[1])
        if book_id.length > 0
          bk.read_book(book_id)
          bk.create_book_content
        end
      end
      puts "-------------------------------"
    end
  end
  
  def select_result(list)
    return 0 if !list || list.count < 1
    return 1 if list.count == 1
    list.each_with_index do |item, idx|
      puts "#{idx + 1})\t#{item}"
    end
    c = 0
    until c > 0 do
      puts "Please select: "
      c = gets.to_i
    end
    c
  end
  
end



require 'yaml'
require 'active_record'
config = YAML::load(File.open('../../config/database.yml'))
ActiveRecord::Base.establish_connection(config['development'])

require '../app/models/book.rb'
require '../app/models/book_chapter.rb'

bp = BookParser.new
bp.book_list_file "book_list.txt"
bp.run

