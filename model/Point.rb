class Point
	attr_accessor :x,:y

	def initialize(x,y)
		@x = x
		@y = y
	end

	def ==(other)
	    return false unless other.instance_of?(self.class)
	    @x == other.x && @y == other.y
	end
end