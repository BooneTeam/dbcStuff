require 'httparty'
require './token_generator'
require 'pry'

class TwitterApi
  include HTTParty
  include TokenGenerator
  attr_accessor :request_type, :query, :request

  def method_missing(the_method, *args, &block)
    if the_method.to_s =~ /^api_[\w]+/
      set_options_and_request_type(args[0])
      request = {:query => self.query, :headers => {"Authorization" => TokenGenerator.token}}
      if http_method
        HTTParty.send(http_method, url_from_method_name(the_method), request)
      else
        raise ArgumentError, "Twitter API requests need a request type ie: {screen_name:'GarrettB00ne' method : 'get'}"
      end
    else
      super
    end
  end

  def set_options_and_request_type(options)
    self.request_type = options.delete(:method) if options && options[:method]
    self.query = options
  end

  def http_method
    self.request_type && self.request_type.to_s.match(/\bget\b|\bpost\b/i)[0]
  end

  def url_from_method_name(requested_method)
    split_name = requested_method.to_s.split('_')
    split_name.shift
    "https://api.twitter.com/1.1/" + split_name
                                         .map { |s| s.split(/(?=[A-Z])/).join('_').downcase }
                                         .join('/') + ".json"
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('api_') || super
  end

end

twitter = TwitterApi.new

show = twitter.api_users_show({screen_name: "GarrettB00ne", method: "get"}) #=>JSON Response
show = twitter.api_users_show({screen_name: "GarrettB00ne"}) #=> Raises Erorr
puts twitter.respond_to?(:api_users_show) #=> True
puts twitter.respond_to?(:users_show) #=> False