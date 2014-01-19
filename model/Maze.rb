require_relative 'Point'

class Maze
	@dimensions
	@obstacles
	@start_point
	@goal_point

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

	def is_obstacle?(point)
		raise "Invalid point #{point}" unless point
		@obstacles.include? point
	end

	private
		def create_maze(maze_file)
			mz = YAML.load_file maze_file
			raise "Please define maze dimensions" unless mz[:dimensions.to_s] || mz[:dimensions.to_s][:x] || mz[:dimensions.to_s][:y]
			raise "Please define robot's start point" unless mz[:start.to_s]
			raise "Please define goal point" unless mz[:goal.to_s]

			@dimensions = Point.new mz[:dimensions.to_s][:x] , mz[:dimensions.to_s][:y]
			@start_point = Point.new mz[:start.to_s][:x] , mz[:start.to_s][:y]
			@goal_point  = Point.new mz[:goal.to_s][:x] , mz[:goal.to_s][:y]

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is out of bountaries" if inside_boundaries? @start_point

			raise "Invalid goal point. Goal point (#{@goal_point.x} , #{@goal_point.y}) is out of bountaries" if inside_boundaries? @goal_point

			mz[:obstacles.to_s].each do |obstacle|
				@obstacles.push Point.new obstacle[:x], obstacle[:y]
			end

			raise "Invalid start point. Start point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @start_point

			raise "Invalid goal point. Goals point (#{@start_point.x} , #{@start_point.y}) is on an obstacle" if is_obstacle? @goal_point

		end

		def inside_boundaries?(point)
			@point.x >0 and @point.x <= @dimensions.x and @point.y > 0 and @point.y <= @dimensions.y
		end


end