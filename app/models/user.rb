class User < ActiveRecord::Base

  AX = {:email => "http://axschema.org/contact/email",
        :first => "http://axschema.org/namePerson/first",
        :last => "http://axschema.org/namePerson/last"}

  acts_as_authentic do |c|
    c.openid_required_fields = [AX[:email], AX[:first], AX[:last], :email, :nickname]
  end

  has_many :snippets, :dependent => :destroy

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end

  private

  def map_openid_registration(reg)
    self.email = (reg["email"] || reg["http://axschema.org/contact/email"]).to_s if self.email.blank?
    self.username = (reg["nickname"] || [reg[AX[:first]], reg[AX[:last]]].flatten.join(' ')).to_s if self.username.blank?
  end
end
