require './token_generator.rb'
require 'httparty'
require 'pry'

class TwitterUser
  include HTTParty
  include TokenGenerator

  def initialize(screen_name)
    @screen_name = screen_name
  end

  def users_timeline
    request = {:query => {:screen_name => @screen_name }, :headers => {"Authorization" => TokenGenerator.token}}
    HTTParty.get("https://api.twitter.com/1.1/statuses/user_timeline.json?",request)
  end

  def users_show
    request = {:query => {:screen_name => @screen_name }, :headers => {"Authorization" => TokenGenerator.token}}
    HTTParty.get("https://api.twitter.com/1.1/users/show.json?",request)
  end

end


user     = TwitterUser.new("GarrettB00ne")
show     = user.users_show

timeline = user.timeline
puts show
puts timeline
