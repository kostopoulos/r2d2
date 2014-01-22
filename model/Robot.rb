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

	def print_results
		@maze_visited.select{|mv| @maze_visited[mv]==1 }.keys.each{|point| point.print}
	end

	def up
		point = Point.new @position.x, @position.y
		point.y +=1
		return point
	end

	def down
		point = Point.new @position.x, @position.y
		point.y -=1
		return point
	end

	def right
		point = Point.new @position.x, @position.y
		point.x +=1
		return point
	end

	def left
		point = Point.new @position.x, @position.y
		point.x -=1
		return point
	end

end