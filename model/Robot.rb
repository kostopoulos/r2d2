class Robot
	attr_accessor :maze_visited, :previous_positions
	attr_reader :position

	DIRECTIONS = [:up,:right, :down, :left]

	def initialize(position)
		@position = position
		@maze_visited = {position => 1}
		@previous_positions = []
	end

	def reached_dead_end?
		@maze_visited.include?(up) and @maze_visited.include?(down) and @maze_visited.include?(left) and @maze_visited.include?(right)
	end

	def move_at(point)
		@previous_positions.push @position
		@position = point
	
		if has_visited? @position
			@maze_visited[@position] = 2 
		else
			@maze_visited[@position] = 1
		end

		@previous_positions.push point if point.type == Point::GOAL_POINT

	end

	def move_back
		@position = @previous_positions.pop
	end

	def has_visited?(point)
		@maze_visited.keys.include? point
	end
	def times_visited(point)
		@maze_visited[point]
	end

	def print_results
		"Root found"
		@previous_positions.each{|point| point.print}
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

	def print_position
		puts "Robot's current position"
		@position.print
	end

end