class AddCreatedAtToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end
  def self.up
    add_timestamps :users
    User.reset_column_information
    User.all.each do |user|
      user.created_at = user.updated_at = Time.now
      user.save
    end
  end

  def self.down
    remove_timestamps :users
  end
end
