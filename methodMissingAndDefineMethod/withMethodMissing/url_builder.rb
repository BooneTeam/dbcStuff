class UrlBuilder
  attr_reader :options, :http_call

  def initialize
    @options = {}
    @requested_method = ''
  end

  def append(requested_method, options)
    @http_call = options.delete(:method) if options && options[:method]
    @requested_method = requested_method.to_s
    @options.merge!(options) if options
  end

  def url
    "https://api.twitter.com/1.1/" +
        @requested_method
            .split('_')
            .map { |s| s.split(/(?=[A-Z])/).join('_').downcase }
            .join('/') + ".json"
  end
end