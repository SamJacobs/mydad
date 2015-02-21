require 'rubygems'
require 'sinatra'
require 'rest-client'

require_relative 'info.rb'

# = @consumer_key
# = @consumer_secr
# = @oauth_token
# = @oauth_token_s
# = @auth_method

get '/' do
  erb :mydad
end


# RestClient.get 'http://example.com/resource', {:params => {:id => 50, 'foo' => 'bar'}}

get '/more' do

end