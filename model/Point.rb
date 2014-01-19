class Point
	attr_accessor :x,:y

	START_POINT = :start_point
	GOAL_POINT = :goal_point
	OBSTACLE = :obstacle
	FREE_POINT = :free_point

	TYPES = [START_POINT, GOAL_POINT, OBSTACLE,FREE_POINT]

	def initialize(x,y)
		@x = x
		@y = y
	end

	def ==(other)
	    return false unless other.instance_of?(self.class)
	    @x == other.x && @y == other.y
	end

	def print(type)
		raise "Invalid point type #{type} for point (#{@x}, #{@y})" unless TYPES.include? type
	end
end