require 'sinatra'
require 'twilio-ruby'

get '/sms' do
  response = Twilio::TwiML::Response.new do |r|
  	r.Message('Thanks for helping me out with my talk, people in Portland are awesome.')
  end
  content_type 'text/xml'
  response.text
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APxxxxxx'
  capability.generate
end

get '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  message = client.account.messages.list(to: '+1503xxxxxxx').sample
  response = Twilio::TwiML::Response.new do |r|
  	r.Dial callerId: '+1503xxxxxxx' do |d|
  		d.Number message.from
  	end
  end
  content_type 'text/xml'
  response.text  
end