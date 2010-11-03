class User < ActiveRecord::Base
  has_many :snippets, :dependent => :destroy

  AX = {:email => "http://axschema.org/contact/email",
        :first => "http://axschema.org/namePerson/first",
        :last => "http://axschema.org/namePerson/last"}

  acts_as_authentic do |c|
    c.validate_login_field = false
    c.validate_email_field = false
    c.openid_required_fields = ["email", "nickname", AX[:email], AX[:first], AX[:last]]
  end

  def before_save
    if self.username.nil? || self.username.blank?
      self.username = "user#{Time.now.to_i}"
    end
  end

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end

  private
  def map_openid_registration(reg)
    self.email = (reg["email"] || reg[AX[:email]]).to_s if self.email.blank?
    self.username = (reg["nickname"] || [reg[AX[:first]], reg[AX[:last]]].flatten.join(' ')).to_s if self.username.blank?
  end
end
  