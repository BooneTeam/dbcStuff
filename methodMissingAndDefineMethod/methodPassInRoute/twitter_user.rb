require './token_generator.rb'
require 'httparty'

class TwitterUser
  include HTTParty
  include TokenGenerator

  def initialize(screen_name)
    @screen_name = screen_name
  end

  def api_route(route)
    request = {:query => {:screen_name => @screen_name }, :headers => {"Authorization" => TokenGenerator.token}}
    HTTParty.get("https://api.twitter.com/1.1" + route + ".json?",request)
  end

end

user     = TwitterUser.new("GarrettB00ne")
show     = user.api_route('/users/lookup')

timeline = user.api_route('/statuses/user_timeline')

puts show

puts timeline
