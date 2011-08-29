class CreateBkHistories < ActiveRecord::Migration
  def self.up
    create_table :bk_histories do |t|
      t.integer :client_id
      t.integer :book_id
      t.integer :chapter_id
      t.timestamps
    end

    create_table :bk_hotsites do |t|
      t.string :name
      t.string :url
      t.integer :rank
      t.integer :status, :default => 0
      t.timestamps
    end

    create_table :bk_toplists do |t|
      t.integer :bk_hotsite_id
      t.string :book_name
      t.integer :book_id
      t.integer :rank
      t.timestamps
    end

    create_table :bk_favorites do |t|
      t.integer :client_id
      t.integer :book_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bk_histories
    drop_table :bk_hotsites
    drop_table :bk_toplists
    drop_table :bk_favorites
  end

end