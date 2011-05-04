class CreateCompaniesProductUsages < ActiveRecord::Migration
  def self.up
    create_table :companies_product_usages, :id => false do |t|
    	t.integer :company_id
    	t.integer :product_usage_id
    end
  end

  def self.down
    drop_table :companies_product_usages
  end
end