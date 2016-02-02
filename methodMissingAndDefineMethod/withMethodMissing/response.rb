class TwitterResponse
  attr_reader :errors

  def initialize(hash)
    hash.each do |k, v|
      if v.class == Hash
        TwitterResponse.new v
      else
        self.instance_variable_set("@#{k}", v)
        self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
      end
    end
  end

  def self.construct(res)
    (res.respond_to?(:keys) && res.respond_to?(:to_a)) ? TwitterResponse.new(res) : res.collect { |item| TwitterResponse.new(item) }
  end
end