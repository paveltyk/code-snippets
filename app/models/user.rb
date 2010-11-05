class User < ActiveRecord::Base
  RESERVED_USERNAMES = %w{login logout snippets search register tag users home my}

  has_many :snippets, :dependent => :destroy

  AX = {:email => "http://axschema.org/contact/email",
        :first => "http://axschema.org/namePerson/first",
        :last => "http://axschema.org/namePerson/last"}

  acts_as_authentic do |c|
    c.openid_required_fields = ["email", "nickname", AX[:email], AX[:first], AX[:last]]
  end

  before_validation :check_username
  has_permalink :username, :update => true

  def to_param
    permalink
  end

  private
  
  def map_openid_registration(reg)
    self.email = (reg["email"] || reg[AX[:email]]).to_s if self.email.blank?
    self.username = (reg["nickname"] || [reg[AX[:first]], reg[AX[:last]]].compact.flatten.join(' ')).to_s if self.username.blank?
  end

  def check_username
    self.username = Faker::Name.name.gsub(/'/, '-') if self.username.blank? || RESERVED_USERNAMES.include?((self.username || '').downcase)
    if User.exists?(:username => self.username)
      self.username = "#{self.username} #{Time.now.to_i}"
    end
  end
end
  