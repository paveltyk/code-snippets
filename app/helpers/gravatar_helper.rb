require 'digest/md5'

module GravatarHelper
  def gravatar_for(user, options={})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    options.reverse_merge! :size => 60
    image_tag "http://www.gravatar.com/avatar/#{hash}?s=#{h options[:size]}"
  end
end
