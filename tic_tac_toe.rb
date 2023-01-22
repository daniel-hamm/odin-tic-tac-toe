# frozen_string_literal: true

# Main game class
class Game
  def initialize
    @grid = {}
    self.new_game
  end

  def new_game
    self.create_grid
  end

  def display_grid
    @grid.each_with_index do |value, index|
      print "#{value}\t"
      print "\n" if index == 2 || index == 5
    end
  end

  def add_point
    @points += 1
  end

  def reset_points
    @points = 0
  end

  def display_results
    "#{@name} has #{@points} points."
  end

  private

  def create_grid
    9.times do |i|
      @grid[i] = {
        player: '',
        marker: ''
      }
    end
  end
end

# Player class
class Player < Game
  attr_reader :name, :points

  def initialize(name, points = 0)
    # super
    @name = name
    @points = points
  end
end

game = Game.new

player1 = Player.new('Robert', 0)
player2 = Player.new('Junior', 0)

puts player1.display_results

game.display_grid
