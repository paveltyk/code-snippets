require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.username { Faker::Internet.user_name }
Sham.email { Faker::Internet.email }
Sham.password { Faker.numerify "######" }
Sham.title { Faker::Lorem.sentence }
Sham.description { Faker::Lorem.sentence }
Sham.code { Faker::Lorem.paragraphs }

User.blueprint do
  username
  email
  password
  password_confirmation { password }
end

Snippet.blueprint do
  user
  title
  description
  code
end