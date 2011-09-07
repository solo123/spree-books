# encoding: utf-8
require './book_reader_lnwow.rb'
require 'test/unit'

class TestBooks < Test::Unit::TestCase
  def setup
    @book_reader = BookReaderLnwow.new
  end
  
  def atest_search_hello
    result = @book_reader.search "hello"
    assert_equal([['Hello腹黑皇帝', '/Book/127016/Index.html']], result )
  end
  
  def atest_search_king
    result = @book_reader.search "皇帝"
    assert(result.count > 2, 'Wrong search result!!')
  end
  
  def test_bookid
    assert_equal('1001', @book_reader.get_bookid('/Book/1001/Index.html'))
  end
  
  def test_catalog
    @book_reader.read_book('134261')
    assert_equal('篮球皇帝', @book_reader.title)
    assert_equal('淡水鲨鱼', @book_reader.author)
    assert_equal('2011-9-7 2:27:51', @book_reader.last_update)
  end
end 
