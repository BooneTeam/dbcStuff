#!/usr/bin/env ruby

# Author:: Garrett Boone <http://garrettaustinboone.com>
#
# Copyright:: 2015 Garrett Boone . All Rights Reserved
#
# Licensed under the MIT License
#
# Basic Twitter REST API Wrapper.
#
#
# IE: users/show route can be called
#   client = Twitter.new
#   user = client.users_lookup(:screen_name => "GarrettB00ne")

require 'httparty'
require './url_builder'
require './token_generator'
require 'pry'

class TwitterApi
  include HTTParty
  include TokenGenerator

  def method_missing(the_method, *args, &block)
    @url = UrlBuilder.new(the_method,args[0])
    request = {:query => @url.query, :headers => {"Authorization" => TokenGenerator.token}}
    if http_method
      HTTParty.send(http_method, @url.url, request)
    else
      super
    end
  end

  def http_method
    @url.request_type && @url.request_type.to_s.match(/\bget\b|\bpost\b/i)[0]
  end

  def respond_to_missing?(*args)
    true
  end

end

twitter = TwitterApi.new

show = twitter.users_show({:screen_name => "GarrettB00ne", :method => 'get'})

timeline = twitter.statuses_userTimeline({:screen_name => "GarrettB00ne", method: "get"})

puts show

puts timeline


# @url = UrlBuilder.new(the_method, args[0])
# if http_method
#   self.class.send :define_method, the_method do
#     request = {:query => @url.query, :headers => {"Authorization" => TokenGenerator.token}}
#     HTTParty.send(http_method, @url.url, request)
#   end
#   self.send(the_method)
# end