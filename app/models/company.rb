class Company < ActiveRecord::Base
	has_and_belongs_to_many :product_usages
end
