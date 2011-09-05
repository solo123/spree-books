class CreateBkLogs < ActiveRecord::Migration
  def self.up
    create_table :bk_logs do |t|
      t.integer :client_id
      t.integer :book_id
      t.integer :chapter_id
      t.string :operate
      t.string :url
      t.text :detail
      t.timestamps
    end
  end

  def self.down
    drop_table :bk_logs
  end

end