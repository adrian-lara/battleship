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

  def assign_computer_ships
    @players[1].owner_board.create_board
    assign_computer_ship_location("two-unit")
    @players[1].owner_board.print_board
    assign_computer_ship_location("three-unit", @players[1].owner_board.two_ship_location)
    @players[1].owner_board.print_board
  end

  def assign_computer_ship_location(ship_type, two_ship_location = nil)
    validity = Validation.new("", "", ship_type, two_ship_location)

    shift = head_tail_proximity_difference(ship_type)

    while validity.result == false
      coordinates = []
      random_row_number = rand(0..3)
      random_row = ["A", "B", "C", "D"][random_row_number]
      random_column = rand(1..4)
      coordinates << random_row + random_column.to_s

      random_direction = rand(1..4)
      if random_direction == 1
        new_row_number = (random_row_number + shift) % 4
        adjusted_row = ["A", "B", "C", "D"][new_row_number]
        coordinates << adjusted_row + random_column.to_s
      elsif random_direction == 2
        new_row_number = (random_row_number - shift) % 4
        adjusted_row = ["A", "B", "C", "D"][new_row_number]
        coordinates << adjusted_row + random_column.to_s
      elsif random_direction == 3
        adjusted_column = random_column + shift
        coordinates << random_row + adjusted_column.to_s
      elsif random_direction == 4
        adjusted_column = random_column - shift
        coordinates << random_row + adjusted_column.to_s
      end

      validity = Validation.new(coordinates[0], coordinates[1], ship_type, two_ship_location)
      validity.perform_validation
    end

    update_ship_location(coordinates, ship_type, "computer")
    update_board(validity, ship_type, "computer")
  end

  def head_tail_proximity_difference(ship_type)
    return 1 if ship_type == "two-unit"
    2
  end

  def assign_user_ships
    @players[0].owner_board.create_board
    assignment_prompt
    assign_ship_location("two-unit")
    assign_ship_location("three-unit", @players[0].owner_board.two_ship_location)
    @players[0].owner_board.print_board
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

    update_ship_location(coordinates, ship_type, "user")
    update_board(validity, ship_type, "user")
  end

  def update_ship_location(coordinates, ship_type, user_type)
    user = 0
    user = 1 if user_type == "computer"

    if ship_type == "two-unit"
      @players[user].owner_board.two_ship_location = coordinates
    elsif ship_type == "three-unit"
      @players[user].owner_board.three_ship_location = coordinates
    end
  end

  def update_board(validity_components, ship_type, user_type)
    user = 0
    user = 1 if user_type == "computer"


    head_row = validity_components.head.row_number
    head_column = validity_components.head.column_number
    @players[user].owner_board.working_rows[head_row][head_column] = "X"

    tail_row = validity_components.tail.row_number
    tail_column = validity_components.tail.column_number
    @players[user].owner_board.working_rows[tail_row][tail_column] = "X"

    if ship_type == "three-unit"
      middle_row = validity_components.middle.row_number
      middle_column = validity_components.middle.column_number
      @players[user].owner_board.working_rows[middle_row][middle_column] = "X"
    end
  end

end
