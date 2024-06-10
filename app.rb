require 'sinatra'
require 'sendgrid-ruby'
include SendGrid


set :public_folder, 'public'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end


post '/send_email' do 

  from = SendGrid::Email.new(email: 'maraghy@milia.com.sa')
  to = SendGrid::Email.new(email: 'maraghy@milia.com.sa')

  subject = "Service Request From #{params["email"]}"

  content = SendGrid::Content.new(type: 'text/plain', value: "Service Request From client #{params["name"]} with #{params["email"]} and phone #{params["phone"]} and requested  #{params["service"]} with message #{params["message"]}")
  mail = SendGrid::Mail.new(from, subject, to, content)
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  send_file File.join(settings.public_folder, 'index.html')
end