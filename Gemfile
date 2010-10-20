source 'http://rubygems.org'

gem 'rails', '2.3.8'
gem 'jrails', '~> 0.6'
gem 'haml', '~> 2.2.24'
gem 'simple-navigation', '~> 2.5.3'
gem 'ruby-openid', '~> 2.1.8', :require => 'openid'
gem 'authlogic', '~> 2.1.6'
gem 'authlogic-oid', '~> 1.0.4', :require => 'authlogic_openid'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'mysql'
  gem 'mongrel'
end

group :test do
  gem 'rspec', '~> 1.3.0'
  gem 'rspec-rails', '~> 1.3.2'
  gem 'machinist', '~> 1.0.6'
  gem 'faker', '~> 0.3.1'
end
