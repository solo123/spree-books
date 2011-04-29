class Balance < ActiveRecord::Base
	belongs_to :company
	belongs_to :product
end
