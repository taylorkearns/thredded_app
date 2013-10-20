class AddHashIdToTopics < ActiveRecord::Migration
  def up
    add_column :topics, :hash_id, :string
    add_index :topics, :hash_id
  end

  def down
    remove_index :topics, :hash_id
    remove_column :topics, :hash_id
  end
end
