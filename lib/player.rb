require './lib/board'
require './lib/validation'

class Player < Validation

  attr_reader :type
  attr_accessor :owner_board, :progress_board, :turn_history, :two_ship_location, :three_ship_location

  def initialize(type)
    @owner_board = Board.new
    @progress_board = Board.new
    @type = type
    @turn_history = []
    @two_ship_location = []
    @three_ship_location = []
  end

  def assign_ships
    assign_user_ships if @type == "User"
    assign_computer_ships if @type == "Computer"
  end

  def assign_computer_ships
    @owner_board.create_board
    assign_computer_ship("two-unit")
    assign_computer_ship("three-unit", @two_ship_location)
  end

  def assign_computer_ship(ship_type, two_ship_location = nil)
    validity = Validation.new("", "", ship_type, @type, two_ship_location)

    shift = head_tail_proximity_difference(ship_type)

    while validity.result == false
      coordinates = []
      head = random_location
      coordinates << head

      tail = random_tail(head, shift)
      coordinates << tail
      validity = Validation.new(head, tail, ship_type, @type, two_ship_location)
      validity.perform_validation
    end

    coordinates.insert(1, validity.middle.location) if ship_type == "three-unit"

    update_ship_location(coordinates, ship_type)
    update_board(validity, ship_type)
  end

  def random_location
    random_row_number = rand(0..3)
    random_row = ["A", "B", "C", "D"][random_row_number]
    random_column = rand(1..4)
    random_row + random_column.to_s
  end

  def random_tail(location, shift)
    direction = rand(1..2)
    sign = [1, -1][rand(0..1)]
    head = Coordinates.new(location)
    if direction == 1
      new_row_number = (head.row_number + (sign * shift)) % 4
      new_row = ["A", "B", "C", "D"][new_row_number]
      new_row + head.column_number.to_s
    else
      new_column = head.column_number + (sign * shift)
      head.row + new_column.to_s
    end
  end

  def head_tail_proximity_difference(ship_type)
    return 1 if ship_type == "two-unit"
    2
  end

  def update_ship_location(coordinates, ship_type)
    if ship_type == "two-unit"
      @two_ship_location = coordinates
    elsif ship_type == "three-unit"
      @three_ship_location = coordinates
    end
  end

  def update_board(location, ship_type)
    user = 0
    user = 1 if @type == "computer"

    head_row = location.head.row_number
    head_column = location.head.column_number
    @owner_board.working_rows[head_row][head_column] = "X"

    tail_row = location.tail.row_number
    tail_column = location.tail.column_number
    @owner_board.working_rows[tail_row][tail_column] = "X"

    if ship_type == "three-unit"
      middle_row = location.middle.row_number
      middle_column = location.middle.column_number
      @owner_board.working_rows[middle_row][middle_column] = "X"
    end
  end

  def assign_user_ships
    @owner_board.create_board
    assignment_prompt
    assign_user_ship("two-unit")
    assign_user_ship("three-unit", @two_ship_location)
    @owner_board.print_board
  end

  def assignment_prompt
    puts "\nI have laid out my ships on the grid.\n" +
         "You now need to lay out your two ships.\n" +
         "The first is two units long and the\n" +
         "second is three units long.\n" +
         "The grid has A1 at the top left and D4 at the bottom right.\n" +
         "For reference, 'A1 A2' would be a valid two-unit ship input,\n" +
         "and 'A1 C1' would be a valid three-unit ship input.\n\n"
  end

  def assign_user_ship(ship_type, two_ship_location = nil)
    validity = Validation.new("", "", ship_type, @type, two_ship_location)

    while validity.result == false
      @owner_board.print_board
      puts "Enter the squares for the #{ship_type} ship:\n"
      location = gets.chomp
      next puts "That's not a valid entry!" unless location.include?(" ")
      coordinates = location.split(' ', 2)

      validity = Validation.new(coordinates[0], coordinates[1], ship_type, @type, two_ship_location)
      validity.perform_validation
    end

    coordinates.insert(1, validity.middle.location) if ship_type == "three-unit"

    update_ship_location(coordinates, ship_type)
    update_board(validity, ship_type)
  end

end
