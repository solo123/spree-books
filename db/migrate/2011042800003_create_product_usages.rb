class CreateProductUsages < ActiveRecord::Migration
  def self.up
    create_table :product_usages do |t|
    	t.integer :product_id
    	t.string :channel
    	t.integer :company_id
    	t.string :remark
    	t.decimal :price, :precision => 8, :scale => 2, :default => 0
    	t.integer :count
    	t.decimal :amount, :precision => 8, :scale =>2, :default => 0
    	t.integer :status
    	t.timestamps
    end
  end

  def self.down
    drop_table :product_usages
  end
end