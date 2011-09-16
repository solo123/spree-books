# encoding: utf-8
require './books_lnwow.rb'
require 'test/unit'

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
  
  def atest_search_hello
    result = @reader.search "hello"
    assert_equal([['Hello腹黑皇帝', '/Book/127016/Index.html']], result )
  end
  
  def atest_search_king
    result = @reader.search "皇帝"
    assert(result.count > 2, 'Wrong search result!!')
  end
  
  def test_bookid
    assert_equal('1001', @reader.get_bookid('/Book/1001/Index.html'))
  end
  
  def test_catalog
    @reader.read_book('134261')
    assert_equal('篮球皇帝', @reader.title)
    assert_equal('淡水鲨鱼', @reader.author)
    assert_equal('2011-9-7 2:27:51', @reader.last_update)
  end
  
  def test_write
    @reader.read_book('122194')
    @reader.create_book_content
    assert(true, 'ok')
  end
 
end
