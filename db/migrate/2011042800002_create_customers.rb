class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
    	t.integer :company_id
    	t.string :real_name
    	t.string :phone
    	t.string :website
    	t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end