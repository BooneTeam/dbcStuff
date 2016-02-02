require 'httparty'
require './token_generator'
require 'pry'

# API_ROUTES =
#     ["/statuses/user_timeline"]
# def users_show(route,body = {})
#   action(route,body)
# end

class TwitterApi
  include HTTParty
  include TokenGenerator

  API_ROUTES = ["/users/show","/statuses/user_timeline"]

  def self.build_api_methods
    API_ROUTES.each do |route|
      method_name = route.split('/').reject { |c| c.length <= 0 }.join('_').gsub('-', '_')
      define_method("#{method_name}") do |body|
        action(route, body)
      end
    end
  end

  def action(route,body)
    request = {:headers => {"Authorization" => TokenGenerator.token}}
    request.merge!({:query => body})
    HTTParty.get("https://api.twitter.com/1.1" + route + ".json?",request)
  end

  build_api_methods
end

twitter = TwitterApi.new
# pp GC.stat
# puts twitter.users_show({:screen_name => "GarrettB00ne"}) #=> JSON Response
# pp GC.stat
# puts twitter.users_show({:screen_name => "GarrettB00ne"}) #=> JSON Response
# pp GC.stat
# puts twitter.users_show({:screen_name => "GarrettB00ne"}) #=> JSON Response
# pp GC.stat
# twitter.methods # => [:action, :users_show, :statuses_user_timeline ... ]
# pp GC.stat


puts twitter.users_show({:screen_name => "GarrettB00ne"}) #=> JSON Response

# show = user.users_show("/users/show", {:screen_name => "GarrettB00ne"})


