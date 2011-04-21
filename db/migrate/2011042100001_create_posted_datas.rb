class CreatePostedDatas < ActiveRecord::Migration
  def self.up
    create_table :posted_datas do |t|
    	t.text :para
    	t.timestamps
    end
  end

  def self.down
    drop_table :posted_datas
  end
end