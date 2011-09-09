# encoding: utf-8
require 'test/unit'
require './books_lnwow.rb'

class TestBooks < Test::Unit::TestCase
 
  def setup
    @reader = BooksLnwow.new
  end
  def test_simple
    #@reader.read_book('125084')
    #assert_equal('不是冤家不聚头：调皮王妃', @reader.title)
    #assert_equal('穆丹枫', @reader.author)
    #assert_equal('2010-4-23 13:47:12', @reader.last_update)
  end
  
  def test_write
    @reader.read_book('87639')
    @reader.create_book_content
    assert(true, 'ok')
  end
 
end
