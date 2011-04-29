class CreateProductUsagesCompanies < ActiveRecord::Migration
  def self.up
    create_table :product_usages_companies, :id => false do |t|
    	t.integer :company_id
    	t.integer :product_usage_id
    end
  end

  def self.down
    drop_table :product_usages_companies
  end
end