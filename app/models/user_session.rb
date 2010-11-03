class UserSession < Authlogic::Session::Base
  auto_register
  #logout_on_timeout true
  find_by_login_method :find_by_username_or_email
end