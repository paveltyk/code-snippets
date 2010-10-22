class ActsAsTaggableMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    
    create_table :taggings do |t|
      t.column :tag_id, :integer
      t.references :taggable, :polymorphic => true
      t.column :created_at, :datetime
    end

    add_column :snippets, :cached_tag_list, :string

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
    remove_column :snippets, :cached_tag_list
  end
end
