require 'pry'

class UrlBuilder
  attr_accessor :query, :request_type, :url

  def initialize(requested_method,options)
    set_options_and_http_call(options)
    @url = url_from_method_name(requested_method)
  end

  def set_options_and_http_call(options)
    self.request_type = options.delete(:method) if options && options[:method]
    self.query = options
  end

  def url_from_method_name(requested_method)
    "https://api.twitter.com/1.1/" + requested_method.to_s
                                         .split('_')
                                         .map { |s| s.split(/(?=[A-Z])/).join('_').downcase }
                                         .join('/') + ".json"
  end
end