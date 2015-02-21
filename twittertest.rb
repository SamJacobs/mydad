#!/usr/bin/ ruby

require 'rubygems'
require 'tweetstream'
require 'dalli'
require 'htmlentities'
require_relative 'info.rb'

#dc = Dalli::Client.new('localhost:11211')
cache = Dalli::Client.new

encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => '',        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }


TweetStream.configure do |config|
  config.consumer_key       = @consumer_key
  config.consumer_secret    = @consumer_secret
  config.oauth_token        = @oauth_token
  config.oauth_token_secret = @oauth_token_secret
  config.auth_method        = @auth_method
end


TweetStream::Client.new.track('dad') do |status| 
   if status.text =~ /\Amy\sdad\s/i
     nextword = HTMLEntities.new.decode status.text[7...status.text.length]
     nextword = nextword.encode Encoding.find('ASCII'), encoding_options
     if not (nextword.match /\bhttp/i).nil?
       nextwordArray = nextword.split(' ')
       nextwordArray.map! {|word| word[0..3] == "http" ? "<a class=\"link\" href=\"#{word}\">#{word}</a>" : word } 
       nextword = nextwordArray.join(' ')  
     end   
     cache.set('nextword', nextword)
   end
end
