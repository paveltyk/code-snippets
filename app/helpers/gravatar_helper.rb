module GravatarHelper
  require 'digest/md5'
  
  DEFAULT_OPTIONS = {
          :size => 60,
          }

  def gravatar(user, options={})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    options = DEFAULT_OPTIONS.merge(options)
    image_tag "http://www.gravatar.com/avatar/#{hash}?s=#{h options[:size]}"
  end
end