ActionMailer::Base.smtp_settings = {
    domain: '18.216.51.21',
    address:        "smtp.sendgrid.net",
    port:            587,
    authentication: :plain,
    user_name:      'apikey',
    password:       ENV['SENDGRID_API_KEY']
}