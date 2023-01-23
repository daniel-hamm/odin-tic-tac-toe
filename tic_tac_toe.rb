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

  def add_point(players_hash_id)
    @players[players_hash_id][:value] += 1
  end

  def reset_points
    @players.each_with_index do |value, index|
      @players[index][:value] = 0
    end
  end

  def check_grid
    # set the loop counter to 0
    i = 0

    # check the rows
    3.times do
      return true if @grid[i][:marker] == @grid[i + 1][:marker] && @grid[i][:marker] == @grid[i + 2][:marker]

      i += 3
    end

    # set the loop counter to 3
    i = 3

    # check the columns
    3.times do |n|
      return true if @grid[n][:marker] == @grid[n + i][:marker] && @grid[n][:marker] == @grid[n + i + i][:marker]
    end

    false
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

game.set_marker(0, 2)
game.set_marker(0, 5)
game.set_marker(0, 8)

game.display_grid

puts game.check_grid