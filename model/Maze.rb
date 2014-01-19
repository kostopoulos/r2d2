require_relative 'Point'

class Maze
	attr_accessor :dimensions, :obstacles, :start_point, :goal_point

	def initialize
		@dimensions = nil
		@start_point = nil
		@goal_point = nil

		@obstacles = Array.new
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
		point.x >0 and point.x >= @dimensions.x and point.y > 0 and point.y >= @dimensions.y
	end

	def is_obstacle?(point)
		raise "Invalid point #{point}" unless point
		@obstacles.include? point
	end

	def is_free_point?(point)
		is_inside_boundaries?(point) and !is_start_point?(point) and !is_goal_point?(point) and !is_obstacle?(point)
	end

	def is_start_point?(point)
		@start_point.eql? point
	end

	def is_goal_point?(point)
		@goal_point.eql? point
	end

	def print
		(1..@dimensions.x).each do |x|
			(1..@dimensions.y).each do |y|
				point = Point.new x,y
				if is_start_point? point
					point.print Point::START_POINT
				elsif is_goal_point? point
					point.print Point::GOAL_POINT
				elsif is_obstacle? point
					point.print Point::OBSTACLE
				else
					point.print Point::FREE_POINT
				end
			end
		end
	end

	private

		def create_maze(maze_file)
			mz = YAML.load_file maze_file
			raise "Please define maze dimensions" unless mz[:dimensions.to_s] || mz[:dimensions.to_s][:x] || mz[:dimensions.to_s][:y]
			raise "Please define robot's start point" unless mz[:start.to_s]
			raise "Please define goal point" unless mz[:goal.to_s]

			@dimensions = Point.new mz[:dimensions.to_s][:x.to_s] , mz[:dimensions.to_s][:y.to_s]
			@start_point = Point.new mz[:start.to_s][:x.to_s] , mz[:start.to_s][:y.to_s]
			@goal_point  = Point.new mz[:goal.to_s][:x.to_s] , mz[:goal.to_s][:y.to_s]

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is out of bountaries" if is_inside_boundaries? @start_point

			raise "Invalid goal point. Goal point (#{@goal_point.x} , #{@goal_point.y}) is out of bountaries" if is_inside_boundaries? @goal_point

			mz[:obstacles.to_s].each do |obstacle|
				@obstacles.push Point.new obstacle[:x.to_s], obstacle[:y.to_s]
			end

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @start_point

			raise "Invalid goal point. Goals point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @goal_point

		end

end