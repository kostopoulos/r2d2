class Point
	attr_accessor :x,:y, :type

	START_POINT = :start_point
	GOAL_POINT = :goal_point
	OBSTACLE = :obstacle
	FREE_POINT = :free_point

	TYPES = [START_POINT, GOAL_POINT, OBSTACLE,FREE_POINT]

	def initialize(x,y,type=nil)
		@x = x
		@y = y
		@type = type
	end

	def ==(other)
	    return false unless other.instance_of?(self.class)
	    @x == other.x && @y == other.y
	end

	def print
		is_valid?
		puts "(x : #{@x}, y : #{@y}) type : #{@type}"
	end

	def is_valid?
		raise "Invalid point type #{@type} for point (#{@x}, #{@y})" unless TYPES.include? @type
	end
end