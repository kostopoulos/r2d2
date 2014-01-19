class Maze
	@start_point
	@goal_point
	@maze

	def initialize(maze_file=nil)
		read_maze #unless maze_file.nil?
		@maze = Array.new
	end
	
	def read_maze
		maze_settings_file = './mazes/mazes.yml'
		maze_settings = YAML.load_file maze_settings_file

		maze_settings = {} unless maze_settings
		maze_settings[:maze_file.to_s] = "example"
	
		return maze_settings
	end
end