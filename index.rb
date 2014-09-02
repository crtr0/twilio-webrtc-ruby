require 'sinatra'
require 'twilio-ruby'

get '/sms' do
  response = Twilio::TwiML::Response.new do |r|
  	r.Message 'Hey, thanks for helping me out with my demo. Ping me anytime @CarterRabasa if you have any questions.'
  end
  content_type 'text/xml'
  response.text
end

post '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  msg = client.account.messages.list(to: '+15039266296').sample
  response = Twilio::TwiML::Response.new do |r|
  	r.Dial callerId: '+15039266296' do |d|
  		d.Number msg.from
  	end
  end
  content_type 'text/xml'
  response.text
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APaa39bb62e404d184ca4d794735b30dd9'
  capability.generate
end
