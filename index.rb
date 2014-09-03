require 'sinatra'
require 'twilio-ruby'

get '/sms' do 
  response = Twilio::TwiML::Response.new do |r|
  	r.Message 'Thanks for helping me out with my presentation, PDX people are awesome :)'
  end
  content_type 'text/xml'
  response.text
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APaa39bb62e404d184ca4d794735b30dd9'
  capability.generate
end

get '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  message = client.account.messages.list(to: '+15033768572').sample
  response = Twilio::TwiML::Response.new do |r|
  	r.Dial callerId: '+15033768572' do |d|
  		d.Number '202-285-6865' #message.from
  	end
  end
  content_type 'text/xml'
  response.text 
end