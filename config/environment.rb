# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey', # debes dejar tal cual 'apikey'
    :password => ENV['SENDGRID_API_KEY'],
    :domain => 'localhost:3000',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
  else
  ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey', # debes dejar tal cual 'apikey'
    :password => ENV['SENDGRID_API_KEY'],
    :domain => 'heroku.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end