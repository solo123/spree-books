# encoding: utf-8
require 'open-uri'
require 'hpricot'

class Admin::BkToplistsController < Admin::BaseController
  def show
    site = BkHotsite.find_by_id(params[:id])
    BkToplist.where(:bk_hotsite_id => site.id).each do |bk|
       bk.delete
    end
    if site.name == 'hongxiu'
      hongxiu_toplist site 
    elsif site.name == 'huanxia'
      huanxia_toplist site
    elsif site.name == 'qidian'
      qidian_toplist site
    elsif site.name == 'xiaoxiang'
      xiaoxiang_toplist site
    else
      render :text => 'error!'
    end
    
    render :text => 'refesh toplist ok!'
  end
  
  
  def hongxiu_toplist(s)
    iconv = Iconv.new('UTF-8//IGNORE', 'GBK')
    
    doc = Hpricot(open(s.url))
    doc.search('#lbox ul').each do |item|
      toplist = BkToplist.new
      toplist.bk_hotsite_id = s.id  
      toplist.book_name = iconv.iconv (item/'.tt3 a').inner_html
      toplist.rank =  (item/'.t1').inner_html
      toplist.save
    end
  end
  
  def huanxia_toplist(s)
    iconv = Iconv.new('UTF-8//IGNORE', 'GBK')
    
    doc = Hpricot(open(s.url))
    doc.search('#lbox ul').each do |item|
      toplist = BkToplist.new
      toplist.bk_hotsite_id = s.id
      toplist.book_name = iconv.iconv ((item/'.t3 a')[0]).inner_html
      toplist.rank = ((item/'li')[0]).inner_html
      toplist.save
    end
  end
  
  def qidian_toplist(s)
    iconv = Iconv.new('UTF-8//IGNORE', 'gb2312')
    doc = Hpricot(open(s.url))
    doc.search('#textlist tr').each_with_index do |item,index|
      next if index == 0
      toplist = BkToplist.new
      toplist.bk_hotsite_id = s.id
      toplist.book_name = iconv.iconv (item/'td .name').inner_html
      toplist.rank = ((item/'td')[0]).inner_html
      toplist.save
    end
  end
  
  def xiaoxiang_toplist(s)
    iconv = Iconv.new('UTF-8//IGNORE', 'GBK')
    
    doc = Hpricot(open(s.url))
    doc.search('#topten table tr').each_with_index do |item,index|
      next if index == 0
      toplist = BkToplist.new
      toplist.bk_hotsite_id = s.id
      toplist.book_name = iconv.iconv ((item/'a')[0]).inner_html
      toplist.rank = (item/'b').inner_html
      toplist.save
    end
  end
  

  
end