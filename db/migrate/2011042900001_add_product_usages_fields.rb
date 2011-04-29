class AddProductUsagesFields < ActiveRecord::Migration
  def self.up
  	add_column :product_usages, :center, :string
  	add_column :product_usages, :imsi,   :string
  	add_column :product_usages, :name,   :string
  	add_column :product_usages, :version, :string
  end

  def self.down
    remove_column :product_usages, :center
    remove_column :product_usages, :imsi
    remove_column :product_usages, :name
    remove_column :product_usages, :version
  end
end