# encoding: utf-8
require 'open-uri'
require 'hpricot'

class Admin::BkToplistsController < ApplicationController
  def toplist
    site = BkHotsite.find(params[:id])
    if site.hot_book_name == 'hongxiu'
      hongxiu_toplist site.hot_book_url 
    elsif site.hot_book_name == 'huanxia'
      huanxia_toplist site.hot_book_url
    elsif site.hot_book_name == 'qidian'
      qidian_toplist site.hot_book_url
    elsif site.hot_book_name == 'xiaoxiang'
      xiaoxiang_toplist site.hot_book_url
    else
      render 'error!'
    end
  end
  
  
  def hongxiu_toplist(url)
    doc = Hpricot(open(url))
    doc.search('#lbox ul').each do |item|
      toplist = BkToplist.new
      toplist.hot_booksite_id = 1
      toplist.book_name = (item/'.tt3 a').inner_html
      toplist.book_order_num = (item/'.t1').inner_html
      toplist.save
    end
  end
  
  def huanxia_toplist(url)
    doc = Hpricot(open(url))
    doc.search('#lbox ul').each do |item|
      toplist = BkToplist.new
      toplist.hot_booksite_id = 1
      toplist.book_name = (item/'.t3 a').inner_html
      toplist.book_order_num = (item/'.t1').inner_html
      toplist.save
    end
  end
  
  def qidian_toplist(url)
    doc = Hpricot(open(url))
    doc.search('#list1').each do |item|
      toplist = BkToplist.new
      toplist.hot_booksite_id = 1
      toplist.book_name = (item/'#textlist .name').inner_html
      toplist.book_order_num = (item/'').inner_html
      toplist.save
    end
  end
  
  def xiaoxiang_toplist(url)
    doc = Hpricot(open(url))
    doc.search('#topten table tbody').each do |item|
      toplist = BkToplist.new
      toplist.hot_booksite_id = 1
      toplist.book_name = (item/'a').inner_html
      toplist.book_order_num = (item/'b').inner_html
      toplist.save
    end
  end
end