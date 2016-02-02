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
# For posting, attach post at the method chain, e.g.
#   client.statuses.update.post(:status=>"Ruby Metaprogramming Rocks")

require 'httparty'
require './url_builder'
require './response'
require './token_generator'
require 'pry'

class TwitterApi
  include HTTParty
  include TokenGenerator

  def method_missing(method, *args, &block)
    @url = UrlBuilder.new
    @url.append(method, args[0])
    @opts = {:query => @url.options, :headers => {"Authorization" => TokenGenerator.token}}
    if http_method
      response = HTTParty.send(http_method, @url.url, @opts)
      TwitterResponse.construct(response)
      if block_given?
        yield(response)
      end
      response
    else
      super
    end
  end

  def http_method
    @url.http_call && @url.http_call.to_s.match(/\bget\b|\bpost\b/i)[0]
  end

  def respond_to_missing?(*args)
    true
  end

end

twitter = TwitterApi.new

show = twitter.users_show({:screen_name => "GarrettB00ne", :method => 'get'})
puts show

timeline = twitter.statuses_userTimeline({:screen_name => "GarrettB00ne", method: "get"})
puts timeline