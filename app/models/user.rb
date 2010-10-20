class User < ActiveRecord::Base
  require 'authlogic_openid'
  
  acts_as_authentic do |c|
    c.openid_required_fields = [:nickname, :email]  
  end

  has_many :snippets, :dependent => :destroy

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end

  private
  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.username = registration["nickname"] if username.blank?
  end
end
