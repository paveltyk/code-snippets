require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.username { Faker::Internet.user_name }
Sham.email { Faker::Internet.email }
Sham.password { Faker.numerify "######" }

User.blueprint do
  username
  email
  password
  password_confirmation { password }
end