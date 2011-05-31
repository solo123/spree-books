class CreateCmOperates < ActiveRecord::Migration
  def self.up
    create_table :cm_operates do |t|
    	t.integer :cm_user_id
    	t.string :operate
    	t.string :result
  	 	t.timestamps
    end
    create_table :cm_db_operates do |t|
    	t.integer :cm_user_id
    	t.string :operate
    	t.text   :result
    	t.timestamps
    end
  end

  def self.down
    drop_table :cm_operates
    drop_table :cm_db_operates
  end
end