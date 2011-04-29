class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
    	t.string :name
    	t.string :channel
    	t.decimal :balance, :precision => 8, :scale => 2, :default => 0
    	t.datetime :balance_date
    	t.datetime :pay_date
    	t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end