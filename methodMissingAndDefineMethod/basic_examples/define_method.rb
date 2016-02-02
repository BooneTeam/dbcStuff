
class User

  attr_accessor :state

  [:failure, :error, :success].each do |method|
    define_method method do
      self.state = method
    end
  end

end
user = User.new
user.success
puts user.state # => :success