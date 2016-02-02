
class User
  attr_accessor :state, :name

  def initialize
    @state = "success"
    @name = "John"
  end

  def method_missing(the_method, *arguments, &block)
    if the_method.to_s =~ /^what_is_[\w]+/
      self.send(the_method.to_s.split('_').last)
    else
      super
    end
  end

  def respond_to_missing?(the_method, include_private = false)
    if the_method.to_s =~ /^what_is_[\w]+/
      true
    else
      super
    end
  end
end

user = User.new
puts user.what_is_state #=> success
puts user.what_is_name #=> John