require 'machinist/active_record'
require 'sham'
require 'faker'

#  Example
#
#  Sham.email { Faker::Internet.email }
#  Sham.login { Faker::Internet.user_name }
#  Sham.password { Faker.numerify "######" }
#
#  User.blueprint do
#    email
#    login
#    password
#  end