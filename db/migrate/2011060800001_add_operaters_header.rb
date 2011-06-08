class AddOperatersHeader < ActiveRecord::Migration
  def self.up
  	add_column :cm_db_operates, :user_id, :string
  	add_column :cm_db_operates, :response_header, :text
  	add_column :cm_db_operates, :url, :string
  	add_column :cm_db_operates, :request_header, :text
  end

  def self.down
    remove_column :cm_db_operates, :user_id
    remove_column :cm_db_operates, :response_header
    remove_column :cm_db_operates, :url
    remove_column :cm_db_operates, :request_header
  end
end