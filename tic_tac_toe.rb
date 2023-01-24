# Tic Tac Toe game
# frozen_string_literal: true

# Main game class
class Game
  # Allow the players the variable to be read outside of the class
  attr_reader :players

  # initialize method called when creating the class
  def initialize(name0, name1)
    # create the players hash with the name, the points / value and the markers
    @players = { 0 => { name: name0, value: 0, marker: 'X' }, 1 => { name: name1, value: 0, marker: 'O' } }

    # create the empty grid hash
    @grid = {}

    # call the new game method
    self.new_game
  end

  # new game method
  def new_game
    # call the create grid method to create and reset the grid
    self.create_grid
  end

  # method to display the grid
  def display_grid
    print "\n"

    # loop throught the grid hash
    @grid.each_with_index do |value, index|
      # print the marker of every grind index and display as string
      print @grid[index][:marker].to_s

      # add a vertical line for the cross
      print " | " if index == 0 || index == 1 || index == 3 || index == 4 || index == 6 || index == 7

      # add a horizontal line for the cross
      print "\n--+---+--\n" if index == 2 || index == 5
    end
    print "\n\n"
  end

  # method for settings the marker on a given given grid position by the user
  def set_marker(players_hash_id, grid_position)
    # if the grid position is lower 0 or higher 8 (grid is from 0 to 8), return an error (false)
    if grid_position < 0 || grid_position > 8
      print "Grid position not possible!\n\n"
      false
    # if the desired grid position is not an integer (so not an X or O), return an error (false)
    elsif @grid[grid_position][:marker].class != Integer
      print "Position already occupied by player #{@grid[grid_position][:player]}!\n\n"
      false
    # if the above checks pass, place the marker and the users name at the grid position, return true
    else
      @grid[grid_position][:player] = @players[players_hash_id][:name]
      @grid[grid_position][:marker] = @players[players_hash_id][:marker]
      true
    end
  end

  # method for displaying the players points
  def display_points
    # loop through the players hash, depending on how many players we have (keys)
    @players.keys.count.times do |n|
      # print the players name and points
      print "#{@players[n][:name]} has #{@players[n][:value]} points.\n"
    end
    # return nothing
    return
  end

  # method for checking the grid (if a player might have won)
  def check_grid
    # call the four methods for checking the grid
    # the return is an array:
    # 0 -> returns a boolean; true if check passed; false if check didn't pass
    # 1 -> the marker inside the winning row, column, vertically (X or O)
    # so we can check who won (player0 is X, player1 is O)
    if    self.check_rows[0]
      who_won(self.check_rows[1])
      true
    elsif self.check_columns[0]
      who_won(self.check_columns[1])
      true
    elsif self.check_diagonal[0]
      who_won(self.check_diagonal[1])
      true
    elsif self.check_draw
      print "\n#####\nDraw!\n#####\n"
      true
    else
      # if none of the above checks is true, no one has won by now
      false
    end
  end

  # private method down here
  private

  # method for adding a point to the players value depending on their hash id (0 or 1)
  def add_point(players_hash_id)
    # increment the players value inside the players hash
    @players[players_hash_id][:value] += 1
  end

  # method for creating an empty grid
  def create_grid
    # loop 9 times, as we need a 3x3 grid
    9.times do |i|
      # set the grids markers to the loops incrementing variable (0 to 8)
      @grid[i] = {
        player: '',
        marker: i
      }
    end
  end

  # method for checking if there are 3 same markers in a row
  def check_rows
    # set the loop counter to 0
    i = 0

    # loop three times, as we have three rows
    3.times do
      # check the rows first marker with the second marker and the third marker
      if @grid[i][:marker] == @grid[i + 1][:marker] && @grid[i][:marker] == @grid[i + 2][:marker]
        # if all markers are the same, return true and the corrensponding marker in an array
        return [true, @grid[i][:marker]]
      end

      # increment the counter, so we can jump to the next starting grids marker position
      # first loop:   i = 0; check if 0, 1 and 2 are the same
      # second loop:  i = 3; check if 3, 4 and 5 are the same
      # third loop:   i = 6; check if 6, 7 and 8 are the same
      i += 3
    end

    # return false as array if nothing is true
    # has to be an array, because the method calling this method checks for an array at position 0
    [false]
  end

  # method for checking if there are 3 same markers in a column
  def check_columns
    # set the loop counter to 3
    i = 3

    # loop three times, as we have three columns
    3.times do |n|
      # check the columns first marker with the second marker and the third marker
      if @grid[n][:marker] == @grid[n + i][:marker] && @grid[n][:marker] == @grid[n + i + i][:marker]
        # if all markers are the same, return true and the corrensponding marker in an array
        return [true, @grid[n][:marker]]
      end
    end

    # n is the counter variable of the loop
    # first loop:   n = 0; check if 0 (n), 3 (n + i) and 6 (n + i + i) are the same
    # second loop:  n = 1; check if 1 (n), 4 (n + i) and 7 (n + i + i) are the same
    # third loop:   n = 2; check if 2 (n), 5 (n + i) and 8 (n + i + i) are the same

    # return false as array if nothing is true
    # has to be an array, because the method calling this method checks for an array at position 0
    [false]
  end

  # method for checking if there are 3 same markers in the two diagonal rows
  def check_diagonal
    # check if grid positions 0, 4 and 8 are the same
    if    @grid[0][:marker] == @grid[4][:marker] && @grid[0][:marker] == @grid[8][:marker]
      # if all markers are the same, return true and the corrensponding marker in an array
      return [true, @grid[0][:marker]]
    # check if grid positions 2, 4 and 6 are the same
    elsif @grid[2][:marker] == @grid[4][:marker] && @grid[2][:marker] == @grid[6][:marker]
      # if all markers are the same, return true and the corrensponding marker in an array
      return [true, @grid[2][:marker]]
    end

    # return false as array if nothing is true
    # has to be an array, because the method calling this method checks for an array at position 0
    [false]
  end

  # methid for checking if we have a draw
  def check_draw
    # loop through every position in the grid
    @grid.each_with_index do |value, index|
      # if there is a number in the grid (so no X or O), return false as the game is not finished yet
      if @grid[index][:marker] != 'X' && @grid[index][:marker] != 'O'
        # does not have to be a return array, because we don't care about the marker (liker in the other checks)
        return false
      # if we reach the last grid position (8) and there is an X or O, return true
      # because there are no numbers left in the grid and so we have a draw
      elsif (@grid[index][:marker] == 'X' || @grid[index][:marker] == 'O') && index == 8
        # does not have to be a return array, because we don't care about the marker (like in the other checks)
        return true
      end
    end
  end

  # method for checking who won the round
  # we give it a string with the marker given by one of the grid checks (apart from the draw check)
  def who_won(string)
    # loop throught the players hash depending on the numbers of players (keys)
    @players.keys.count.times do |n|
      # if the given string (either X or O) matches a players marker (inside the players hash)
      if @players[n][:marker] == string
        # print the players name
        print "##################\n"
        print "#{@players[n][:name]} won.\n"
        print "##################\n"

        # call the add point method, so the winner gets a point
        add_point(n)
      end
    end
  end
end

# add a run boolean, as we might want to exit the games while loop
run = true

# set the current player to 0, so the starting player is key 0 in the players hash
current_player = 0

# print a welcome message an get the first players name
print "\nWelcome to Tic Tac Toe!\n\nFirst name entered starts the game!\n"
print "\nEnter the first players name: "

# create the name variables globally, so we can reach them in a loop later
name0 = gets.chomp
name1 = ''

# create a loop, for checking if both players entered the same name
loop do
  print "\nEnter the second players name: "
  name1 = gets.chomp

  # if the names are different, break the loop and go on
  break if name0 != name1

  # if the names are the same, restart the loop until not
  print "\nDon't use the same names for a better visual experience!\nEnter new name!\n"
end

print "\nStarting the game!\n"

# create a game instance with the game class
# hand the game class the players names
game = Game.new(name0, name1)

# create an endless game loop
while run

  # display the grid for the players
  game.display_grid

  # create a loop, where the current player enters a grid number
  loop do
    print "It's #{game.players[current_player][:name]}s turn.\nEnter the grid number: "

    # get the grid position (number) the player desires
    grid_position = gets

    print "\n"

    # check if the user has entered something else than a number
    if grid_position !~ /\A\d+\Z/
      print "\nEnter a number\n\n"
    # check if the player has entered a non occupied grid position
    # the return of set_marker it either true or false (when already occupied by the other player)
    elsif game.set_marker(current_player, grid_position.to_i)
      # break the grid number entering loop, if everything is okay
      # if not, restart the loop and make tell the player to enter a new number
      break
    end
  end

  # as the next step, when a correct number was entered and has been inserted in the grid
  # call the check grid method in a condition
  # if it returns true, someone has won the game
  # if it returns false, restart the loop and the next player is in charge
  if game.check_grid
    # display the winning grid to the players
    game.display_grid

    # display the players points
    print "\n"
    print game.display_points
    print "\n"

    # let the players make a decision
    print "Game finished.\n\n=> Press enter for a new round.\n=> Enter 'exit' to stop the game.\nInput: "

    # get the users decision; we don't care about case sensitivity
    decision = gets.downcase.chomp

    # if the user wants to exit, exit the software
    if decision == 'exit'
      exit
    # if the user enters anything else, restart the game
    else
      print "\nRestarting the game!\n"
      print "\nStarting positions switched.\n"
      # call the new_game method to reset the grid to the default (no names and numbers from 0 to 8)
      game.new_game
    end
  end

  # switch the current player before restarting the loop
  current_player == 0 ? current_player = 1 : current_player = 0
end
