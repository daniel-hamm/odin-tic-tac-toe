# frozen_string_literal: true

# Main game class
class Game
  attr_reader :players

  def initialize(name0, name1)
    @players = { 0 => { name: name0, value: 0, marker: 'X' }, 1 => { name: name1, value: 0, marker: 'O' } }
    @grid = {}
    self.new_game
  end

  def new_game
    self.create_grid
  end

  def display_grid
    print "\n"
    @grid.each_with_index do |value, index|
      print @grid[index][:marker].to_s
      print " | " if index == 0 || index == 1 || index == 3 || index == 4 || index == 6 || index == 7
      print "\n--+---+--\n" if index == 2 || index == 5
    end
    print "\n\n"
  end

  def set_marker(players_hash_id, grid_position)
    if @grid[grid_position][:marker].class != Integer
      puts "Position already occupied by player #{@grid[grid_position][:player]}!"
      false
    else
      @grid[grid_position][:player] = @players[players_hash_id][:name]
      @grid[grid_position][:marker] = @players[players_hash_id][:marker]
    end
  end

  def display_points
    @players.keys.count.times do |n|
      print "#{@players[n][:name]} has #{@players[n][:value]} points.\n"
    end
  end

  def add_point(players_hash_id)
    @players[players_hash_id][:value] += 1
  end

  def reset_points
    @players.each_with_index do |value, index|
      @players[index][:value] = 0
    end
  end

  def check_rows
    # set the loop counter to 0
    i = 0

    # check the rows
    3.times do
      if @grid[i][:marker] == @grid[i + 1][:marker] && @grid[i][:marker] == @grid[i + 2][:marker]
        return [true, @grid[i][:marker]]
      end

      i += 3
    end

    # return false as array if nothing is true
    [false]
  end

  def check_columns
    # set the loop counter to 3
    i = 3

    # check the columns
    3.times do |n|
      if @grid[n][:marker] == @grid[n + i][:marker] && @grid[n][:marker] == @grid[n + i + i][:marker]
        return [true, @grid[n][:marker]]
      end
    end

    # return false as array if nothing is true
    [false]
  end

  def check_vertically
    # check vertically
    if    @grid[0][:marker] == @grid[4][:marker] && @grid[0][:marker] == @grid[8][:marker]
      return [true, @grid[0][:marker]]
    elsif @grid[2][:marker] == @grid[4][:marker] && @grid[2][:marker] == @grid[6][:marker]
      return [true, @grid[2][:marker]]
    end

    # return false as array if nothing is true
    [false]
  end

  def who_won(string)
    @players.keys.count.times do |n|
      if @players[n][:marker] == string
        print "#{@players[n][:name]} won.\n"
        add_point(n)
      end
    end
  end

  def check_grid
    if    self.check_rows[0]
      who_won(self.check_rows[1])
      true
    elsif self.check_columns[0]
      who_won(self.check_columns[1])
      true
    elsif self.check_vertically[0]
      who_won(self.check_vertically[1])
      true
    else
      false
    end
  end

  private

  def create_grid
    9.times do |i|
      @grid[i] = {
        player: '',
        marker: i
      }
    end
  end
end

game = Game.new("Robert", "Junior")

puts game.players

game.add_point(0)

puts game.players

game.reset_points

puts game.players

game.display_grid

game.set_marker(1, 0)
game.set_marker(1, 1)
game.set_marker(1, 2)

game.display_grid

game.check_grid

game.display_points