
datas = YAML::load(File.open("#{RAILS_ROOT}/bkb/db/load_data/bk_hotsites.yml"))

datas.each do |data|
  site = BkHotsite.find_by_id data[0]
  if !site
    site = BkHotsite.new data[1]
    site.id = data[0]
    site.save
  end
end 

