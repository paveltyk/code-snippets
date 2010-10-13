class User < ActiveRecord::Base
  acts_as_authentic
  has_many :snippets, :dependent => :destroy

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end
end
