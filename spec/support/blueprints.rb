require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.username { Faker::Internet.user_name }
Sham.email { Faker::Internet.email }
Sham.openid_identifier { [%w{http https}.rand, '://', Faker::Internet.domain_name].join }
Sham.title { Faker::Lorem.sentence }
Sham.description { Faker::Lorem.sentence }
Sham.code { Faker::Lorem.paragraphs }

User.blueprint do
  username
  email
  openid_identifier
end

Snippet.blueprint do
  user
  description
  code
end