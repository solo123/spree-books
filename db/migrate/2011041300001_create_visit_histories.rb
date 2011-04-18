class CreateVisitHistories < ActiveRecord::Migration
  def self.up
    create_table :visit_histories do |t|
    	t.string :url
    	t.text :head

	 	t.timestamps
    end
  end

  def self.down
    drop_table :visit_histories
  end
end