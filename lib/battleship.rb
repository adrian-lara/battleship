require 'pry'
require './lib/player'
require './lib/validation'

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
    assign_ship_location("two-unit")
    #update owner_board to reflect placement of two ship
    assign_ship_location("three-unit", @players[0].owner_board.two_ship_location)
    #update owner_board to reflect placement of two ship
  end

  def assignment_prompt
    puts "\nI have laid out my ships on the grid.\n" +
         "You now need to layout your two ships.\n" +
         "The first is two units long and the\n" +
         "second is three units long.\n" +
         "The grid has A1 at the top left and D4 at the bottom right.\n\n"
  end

  def assign_ship_location(ship_type, two_ship_location = nil)
    validity = Validation.new("", "", ship_type, two_ship_location)

    while validity.result == false
      @players[0].owner_board.print_board
      puts "Enter the squares for the #{ship_type} ship:\n"
      location = gets.chomp
      next puts "That's not on the board!" unless location.include?(" ")
      coordinates = location.split(' ', 2)

      validity = Validation.new(coordinates[0], coordinates[1], ship_type, two_ship_location)
      validity.perform_validation
    end

    update_ship_location(coordinates, ship_type)
  end

  def update_ship_location(coordinates, ship_type)
    if ship_type == "two-unit"
      @players[0].owner_board.two_ship_location = coordinates
    elsif ship_type == "three-unit"
      @players[0].owner_board.three_ship_location = coordinates
    end
  end

end
