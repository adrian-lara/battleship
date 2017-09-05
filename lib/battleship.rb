require 'pry'
require './lib/player'

class Battleship

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [user = Player.new, computer = Player.new]
    @timer = nil
    @winner = nil
  end

  # def game_setup
  #
  # end

  def assign_user_ships
    @players[0].owner_board.create_board
    assignment_prompt
    # assign_two_ship_location
  end

  def assignment_prompt
    puts "\nI have laid out my ships on the grid.\n" +
         "You now need to layout your two ships.\n" +
         "The first is two units long and the\n" +
         "second is three units long.\n" +
         "The grid has A1 at the top left and D4 at the bottom right.\n\n"
  end

  def assign_two_ship_location
    @players[0].owner_board.print_board
    puts "Enter the squares for the two-unit ship:\n"
    location = gets.chomp

    @players[0].owner_board.two_ship_location = location.split(' ')
  end


end
