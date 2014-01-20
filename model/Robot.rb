class Robot
	attr_accessor :known_maze, :previous_position
	attr_reader :position

	def initialize
		@position = Point.new 0,0 #set up an invalide position
		@previous_position = Point.new 0,0 #set up an invalide position
		@known_maze = Array.new
	end

	def set_position(point)
		@position = point
		Array.new 
	end

	def cannot_solve_maze?
		@known_maze.include?(up) and @known_maze.include?(down) and @known_maze.include?(left) and @known_maze.include?(right)
	end

	def move
		@previous_position = @position
	end

	def learn_point(point)
		point.is_valid?
		@known_maze.push point
	end

	def up
		point = @position
		point.y +=1
		return point
	end

	def down
		point = @position
		point.y -=1
		return point
	end

	def right
		point = @position
		point.x +=1
		return point
	end

	def left
		point = @position
		point.x -=1
		return point
	end

end