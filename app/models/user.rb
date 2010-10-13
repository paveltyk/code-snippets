class User < ActiveRecord::Base

  def self.find_by_username_or_email(login)
    User.find_by_username(login) || User.find_by_email(login)
  end

  acts_as_authentic
  has_many :snippets, :dependent => :destroy
end
