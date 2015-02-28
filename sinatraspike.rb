require 'rubygems'
require 'sinatra'
require 'uri'
require 'rest-client'
require 'base64'
require 'twitter'
require 'htmlentities'

require_relative 'info'

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     =  $consumer_secret
end

encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => '',        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }


$auth_method        = :oauth

get '/' do
  erb :mydad
end

get '/more' do
	$client.search("'my dad'", result_type: "recent").each do |tweet|
		if tweet.text =~ /\Amy\sdad\s/i
			tweet = HTMLEntities.new.decode tweet.text[7...tweet.text.length]
			tweet = tweet.encode Encoding.find('ASCII'), encoding_options
			if not (tweet.match /\bhttp/i).nil?
				nextwordArray = tweet.split(' ')
				nextwordArray.map! {|word| word[0..3] == "http" ? "<a class=\"link\" href=\"#{word}\">#{word}</a>" : word } 
				tweet = nextwordArray.join(' ')  
			end   
    		return tweet
    	end
	end
end