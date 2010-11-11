class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.references :follower, :followed
      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end

  def self.down
    drop_table :relationships
  end
end
