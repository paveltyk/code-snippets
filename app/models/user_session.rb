class UserSession < Authlogic::Session::Base
   attr_accessor :email, :password, :login
   find_by_login_method :find_by_username_or_email   
end