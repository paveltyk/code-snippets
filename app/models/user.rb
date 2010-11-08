class User < ActiveRecord::Base
  RESERVED_USERNAMES = %w{login logout snippets search register tag users home my}

  has_many :snippets, :dependent => :destroy
  #attr_accessor :crypted_password_field, :password_salt_field, :password, :password_confirmation

  AX = {:email => "http://axschema.org/contact/email",
        :first => "http://axschema.org/namePerson/first",
        :last => "http://axschema.org/namePerson/last"}

  acts_as_authentic do |c|
    c.openid_required_fields = ["email", "nickname", AX[:email], AX[:first], AX[:last]]
  end

  before_validation :normalize_username, :if => :authenticate_with_openid?
  validate :validate_reserved_usernames

  has_permalink :username, :update => true

  def to_param
    permalink
  end

  private
  
  def map_openid_registration(reg)
    self.email = (reg["email"] || reg[AX[:email]]).to_s if self.email.blank?
    self.username = (reg["nickname"] || [reg[AX[:first]], reg[AX[:last]]].compact.flatten.join(' ')).to_s if self.username.blank?
  end

  def normalize_username
    self.username = Faker::Name.name.gsub(/'/, '-') if username.blank? || username_reserved?
    while username_taken?
      self.username = "#{username} #{Time.now.to_i}"
    end
  end

  def validate_reserved_usernames
    errors.add :username, 'is reserved.' if username_reserved?
  end

  def username_taken?
    User.exists? ['users.username = ? AND users.id != ?', username, id.to_i]
  end

  def username_reserved?
    RESERVED_USERNAMES.include? self.username.to_s.downcase
  end

  def attributes_to_save
    attributes.clone.delete_if do |k, v|
      [:id, :persistence_token, :perishable_token, :single_access_token, :login_count, :failed_login_count,
       :last_request_at, :current_login_at, :last_login_at, :current_login_ip, :last_login_ip, :created_at,
       :updated_at, :lock_version].include?(k.to_sym)
    end
  end
end
  