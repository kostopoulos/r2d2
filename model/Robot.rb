class Robot
	attr_accessor :maze_visited, :previous_position
	attr_reader :position

	DIRECTIONS = [:up,:right, :down, :left]

	def initialize(position)
		@position = position
		@previous_position = position
		@maze_visited = Hash.new
	end

	def cannot_solve_maze?
		@maze_visited.include?(up) and @maze_visited.include?(down) and @maze_visited.include?(left) and @maze_visited.include?(right)
	end

	def move_at(point)
		@previous_position = @position
		@position = point
	
		if @maze_visited[@position]
			@maze_visited[@position] += 1 
		else
			@maze_visited[@position] = 1
		end

	end

	def has_visited?(point)
		@maze_visited.include? point
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