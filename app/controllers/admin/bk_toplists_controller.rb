# encoding: utf-8
require 'open-uri'
require 'hpricot'

class Admin::BkToplistsController < Admin::BaseController
  def toplist
    site = BkHotsite.find(params[:id])
    if site.hot_book_name == 'hongxiu'
      hongxiu_toplist site.hot_book_url
    end
  end
  
  def hongxiu_toplist(url)
    doc = Hpricot(open(url))
    doc.search('#lbox ul').each do |item|
      toplist = BkToplist.new
      toplist.hot_booksite_id = 1
      toplist.book_name = (item/'.tt3 a').text.force_encoding("UTF-8")
      toplist.book_order_num = (item/'.t1').text.force_encoding("UTF-8")
      toplist.save
    end
  end
end