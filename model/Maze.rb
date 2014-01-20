require_relative 'Point'
require_relative 'Robot'


class Maze
	attr_accessor :dimensions, :obstacles, :start_point, :goal_point, :robot

	def initialize
		@dimensions = nil
		@start_point = nil
		@goal_point = nil

		@obstacles = Array.new

		@robot = Robot.new
	end

	def find_exit
		@robot.set_position @start_point
		until robot_achieved_goal? or @robot.cannot_solve_maze?
			@robot.move
			robot_neighbour.each{|p| @robot.learn_point p}
		end
	end
	
	def read_maze
		folder = './mazes/'
		maze_settings_file = "#{folder}mazes.yml"
		maze_settings = YAML.load_file maze_settings_file
		maze_settings = {} unless maze_settings
		maze_settings[:maze_file.to_s] = "example"
		maze_file = "#{folder}#{maze_settings[:maze_file.to_s]}.yml"

		raise "Please select a different maze file. File #{folder}#{maze_file} does not exists" unless File.exists? maze_file

		create_maze maze_file
	
		return maze_settings
	end

	def is_inside_boundaries?(point)
		raise "Invalid point #{point}" unless point
		point.x >0 and point.x <= @dimensions.x and point.y > 0 and point.y <= @dimensions.y
	end

	def is_obstacle?(point)
		is_inside_boundaries?(point) and @obstacles.include?(point)
	end

	def is_free_point?(point)
		is_inside_boundaries?(point) and !is_start_point?(point) and !is_goal_point?(point) and !is_obstacle?(point)
	end

	def is_start_point?(point)
		is_inside_boundaries?(point) and @start_point.x == point.x and @start_point.y == point.y
	end

	def is_goal_point?(point)
		is_inside_boundaries?(point) and @goal_point.x == point.x and @goal_point.y == point.y
	end

	def print
		(1..@dimensions.x).each do |x|
			(1..@dimensions.y).each do |y|
				point = point_at x,y
				point.print if point
			end
		end
	end

	private
		def robot_neighbour
			neighbour_points = [point_at( @robot.up.x    , @robot.up.y), 
								point_at( @robot.down.x  , @robot.down.y),
								point_at( @robot.left.x  , @robot.left.y),
								point_at( @robot.right.x , @robot.right.y)]

			neighbour_points.delete_if{|p| p.nil? || !is_inside_boundaries?(p) }
		end

		def robot_achieved_goal?
			@robot.position.x == @goal_point.x and @robot.position.y == @goal_point.x
		end

		def create_maze(maze_file)
			mz = YAML.load_file maze_file
			raise "Please define maze dimensions" unless mz[:dimensions.to_s] || mz[:dimensions.to_s][:x] || mz[:dimensions.to_s][:y]
			raise "Please define robot's start point" unless mz[:start.to_s]
			raise "Please define goal point" unless mz[:goal.to_s]

			@dimensions = Point.new mz[:dimensions.to_s][:x.to_s] , mz[:dimensions.to_s][:y.to_s]
			@start_point = Point.new mz[:start.to_s][:x.to_s] , mz[:start.to_s][:y.to_s]
			@goal_point  = Point.new mz[:goal.to_s][:x.to_s] , mz[:goal.to_s][:y.to_s]

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is out of bountaries" unless is_inside_boundaries? @start_point

			raise "Invalid goal point. Goal point (#{@goal_point.x} , #{@goal_point.y}) is out of bountaries" unless is_inside_boundaries? @goal_point

			mz[:obstacles.to_s].each do |obstacle|
				@obstacles.push Point.new obstacle[:x.to_s], obstacle[:y.to_s], Point::OBSTACLE
			end

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @start_point

			raise "Invalid goal point. Goals point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @goal_point
		end

		def point_at(x,y)
			point = Point.new x,y
			return nil unless is_inside_boundaries? point
			if is_start_point? point
				point.type =  Point::START_POINT
			elsif is_goal_point? point
				point.type = Point::GOAL_POINT
			elsif is_obstacle? point
				point.type = Point::OBSTACLE
			else
				point.type = Point::FREE_POINT
			end

			return point
		end

end