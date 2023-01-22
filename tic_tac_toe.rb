# frozen_string_literal: true

# Main game class
class Game
  def add_point
    @points += 1
  end

  def reset_points
    @points = 0
  end

  def display_results
    "#{@name} has #{@points} points."
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
