class RemoveTitleFromSnippets < ActiveRecord::Migration
  def self.up
    Snippet.find_in_batches do |batch|
      batch.each do |snippet|
        snippet.description = [snippet.title, snippet.description].compact.join("\n")
        snippet.save
      end
    end
    remove_column :snippets, :title
  end

  def self.down
    add_column :snippets, :title, :string
    Snippet.reset_column_information
    Snippet.find_in_batches do |batch|
      batch.each do |snippet|
        snippet[:title] = snippet.title
        snippet.save
      end
    end
  end
end
