#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'yaml'
require './model/Maze'


maze = Maze.new
maze.read_maze
puts "maze:"
maze.print
puts "______"
maze.find_exit
