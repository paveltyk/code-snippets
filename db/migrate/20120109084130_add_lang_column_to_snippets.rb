class AddLangColumnToSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :lang, :string
  end

  def self.down
    remove_column :snippets, :lang
  end
end
