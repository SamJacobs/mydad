require 'rubygems'
require 'sinatra'
require 'uri'
require 'rest-client'
require 'base64'
require 'twitter'

require_relative 'info'

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     =  $consumer_secret
end

$auth_method        = :oauth

get '/' do
  erb :mydad
end

get '/more' do
	$client.search("'my dad'", result_type: "recent").each do |tweet|
		if tweet.text =~ /\Amy\sdad\s/i
    		return tweet.text[7...tweet.text.length]
    	end
	end
end