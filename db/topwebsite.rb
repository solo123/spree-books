
File.open("#{RAILS_ROOT}/db/load_data/bk_hotsites.yml", 'w') do |file|
  BkHotsite.all.each do |site|
    file.write site.to_yaml
  end
end
