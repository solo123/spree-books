Devise.setup do |config|
	config.authentication_keys = [ :login ]
end

Spree::Config.set(:default_locale => 'zh-CN')
Spree::Config.set(:logo => '/images/blue_book.png')
