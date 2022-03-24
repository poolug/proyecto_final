ActionMailer::Base.smtp_settings = {
  :user_name => ENV['sendgrid_user_id'], # This is the string literal 'apikey', NOT the ID of your API key
  :password => ENV['sendgrid_api_key'],
  :domain => 'https://chanchito-sano-poolug.herokuapp.com/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}