#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'yaml'
require './model/Maze'

maze =  YAML.load_file './mazes/example.yml'



maze = Maze.new
