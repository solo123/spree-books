class CreateBalances < ActiveRecord::Migration
  def self.up
    create_table :balances do |t|
    	t.datetime :balance_date
    	t.integer :product_id
    	t.string :channel
    	t.integer :company_id
    	t.decimal :price, :precision => 8, :scale => 2, :default => 0
    	t.integer :count
    	t.decimal :amount, :precision => 8, :scale =>2, :default => 0
    	t.string :remark
    	t.integer :status
    	t.timestamps
    end
  end

  def self.down
    drop_table :balances
  end
end