require_relative 'player'
require_relative 'direction'
require_relative 'mirror'

class Maze
  include Direction
  include Mirror

  def initialize(input)
    inputs = IO.readlines(input).collect{|line| line.chomp.split(' ')}
    @maze = Array.new(inputs[0][1].to_i) { Array.new(inputs[0][0].to_i) }
    (2..inputs.size-1).each do |i|
      @maze[@maze[0].size-inputs[i][1].to_i][inputs[i][0].to_i] = inputs[i][2]
    end
    @player = Player.new(@maze.size-1-inputs[1][1].to_i, inputs[1][0].to_i, inputs[1][2])
  end

  def move(output)
    i, j, d = @player.x, @player.y, @player.direction
    steps, infinite, hash = 0, false, {}
    until i < 0 || i > @maze.size-1 || j < 0 || j > @maze[0].size-1
      if hash[[i, j]]
        infinite = true
        break
      end
      hash[[i, j]] = true unless i == @player.x && j == @player.y
      if (@maze[i][j] == BACKSLASH && d == Direction::NORTH) || (@maze[i][j] == FORWARD_SLASH && d == Direction::SOUTH)
        j -= 1
        d = Direction::WEST
      elsif (@maze[i][j] == BACKSLASH && d == Direction::SOUTH) || (@maze[i][j] == FORWARD_SLASH && d == Direction::NORTH)
        j += 1
        d = Direction::EAST
      elsif (@maze[i][j] == BACKSLASH && d == Direction::WEST) || (@maze[i][j] == FORWARD_SLASH && d == Direction::EAST)
        i -= 1
        d = Direction::NORTH
      elsif (@maze[i][j] == BACKSLASH && d == Direction::EAST) || (@maze[i][j] == FORWARD_SLASH && d == Direction::WEST)
        i += 1
        d = Direction::SOUTH
      elsif d == Direction::WEST
        j -= 1
      elsif d == Direction::EAST
        j += 1
      elsif d == Direction::NORTH
        i -= 1
      elsif d == Direction::SOUTH
        i += 1
      else
      end
      steps += 1
    end
    i += 1 if i < 0
    j += 1 if j < 0
    i -= 1 if i > @maze.size-1
    j -= 1 if j > @maze[0].size-1
    steps -= 1 unless steps == 0
    steps = -1 if infinite
    write_to_file(output, steps, j, @maze.size-1-i)
  end

  private
  def write_to_file(output, steps, i, j)
    File.open(output, 'w+') { |f| f.puts(steps) }
    File.open(output, 'a+') { |f| f.puts(i.to_s+' '+j.to_s) } unless steps == -1
  end

end