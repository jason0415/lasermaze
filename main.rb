require './maze'
require 'fileutils'

input, output = ARGV[0], ARGV[1]
# input, output = 'input/file1', 'output/file1'
dirname  = File.dirname(output)
unless File.directory?(dirname)
  FileUtils.mkdir_p(dirname)
end

maze = Maze.new(input)
maze.move(output)