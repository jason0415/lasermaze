require 'spec_helper'

describe Maze do

  context 'when it has a solution' do
    it 'should be valid' do
      maze = Maze.new('input/file')
      maze.move('output/file')
      res = IO.readlines('output/file')
      expect(res).to eq(["9\n", "0 0\n"])
    end
    it 'should be valid when go to S' do
      maze = Maze.new('input/file1')
      maze.move('output/file1')
      res = IO.readlines('output/file1')
      expect(res).to eq(["0\n", "0 0\n"])
    end
    it 'should be valid when go to N' do
      maze = Maze.new('input/file2')
      maze.move('output/file2')
      res = IO.readlines('output/file2')
      expect(res).to eq(["9\n", "0 9\n"])
    end
    it 'should be valid when go to W' do
      maze = Maze.new('input/file3')
      maze.move('output/file3')
      res = IO.readlines('output/file3')
      expect(res).to eq(["0\n", "0 0\n"])
    end
    it 'should be valid when go to E' do
      maze = Maze.new('input/file4')
      maze.move('output/file4')
      res = IO.readlines('output/file4')
      expect(res).to eq(["9\n", "9 0\n"])
    end
  end

  context 'when it has a loop' do
    it 'should return a valid output' do
      maze = Maze.new('input/file5')
      maze.move('output/file5')
      res = IO.readlines('output/file5')
      expect(res).to eq(["-1\n"])
    end
  end

end