class AddPermalinkToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base; has_permalink :username, :update => true; end

  def self.up
    add_column :users, :permalink, :string
    User.reset_column_information
    User.all.each(&:save)
    add_index :users, :permalink
  end

  def self.down
    remove_column :users, :permalink
  end
end
