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
    if   grid_position < 0 || grid_position > 8
      print "Grid position not possible!\n\n"
      false
    elsif    @grid[grid_position][:marker].class != Integer
      print "Position already occupied by player #{@grid[grid_position][:player]}!\n\n"
      false
    else
      @grid[grid_position][:player] = @players[players_hash_id][:name]
      @grid[grid_position][:marker] = @players[players_hash_id][:marker]
      true
    end
  end

  def display_points
    @players.keys.count.times do |n|
      print "#{@players[n][:name]} has #{@players[n][:value]} points.\n"
    end
    return
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

  def add_point(players_hash_id)
    @players[players_hash_id][:value] += 1
  end

  def reset_points
    @players.each_with_index do |value, index|
      @players[index][:value] = 0
    end
  end

  def create_grid
    9.times do |i|
      @grid[i] = {
        player: '',
        marker: i
      }
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
        print "##################\n"
        print "#{@players[n][:name]} won.\n"
        print "##################\n"
        add_point(n)
      end
    end
  end
end

run = true
current_player = 0

print "\nWelcome to Tic Tac Toe!\n\nFirst name entered starts the game!\n"
print "\nEnter the first players name: "
name1 = gets.chomp
name2 = ''

loop do
  print "\nEnter the second players name: "
  name2 = gets.chomp
  break if name1 != name2

  print "\nDon't use the same names for a better visual experience!\nEnter new name!\n"
end
print "\nStarting the game!\n"

game = Game.new(name1, name2)

while run
  game.display_grid

  loop do
    print "It's #{game.players[current_player][:name]}s turn.\nEnter the grid number: "

    grid_position = gets

    print "\n"

    if grid_position !~ /\A\d+\Z/
      print "\nEnter a number\n\n"
    elsif game.set_marker(current_player, grid_position.to_i)
      break
    end
  end

  if game.check_grid
    game.display_grid
    print "\n"
    print game.display_points
    print "\n"
    print "Game finished.\n\n=> Press enter for a new round.\n=> Enter 'exit' to stop the game.\nInput: "
    decision = gets.downcase.chomp
    if decision == 'exit'
      exit
    else
      print "\nRestarting the game!\n"
      print "\nStarting positions switched.\n"
      game.new_game
    end
  end

  current_player == 0 ? current_player = 1 : current_player = 0
end
