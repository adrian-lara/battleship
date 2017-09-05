require 'pry'

class Board

  attr_reader :size, :border, :header_row
  attr_accessor :working_rows, :two_ship_location, :three_ship_location

  def initialize(size = 4)
    @size = size
    @border = ""
    @header_row = []
    @working_rows = []
    @two_ship_location = []
    @three_ship_location = []
  end

  def create_board(size = @size)
    create_border(size)
    create_header_row(size)
    create_working_rows(size)
  end

  def create_border(size)
    @border = "=" * (2 + (size * 2))
  end

  def create_header_row(size)
    @header_row = (1..size).to_a
    @header_row.unshift(".")
    @header_row = @header_row.join(" ")
  end

  def create_working_rows(size)
    letters = ("A".."L").to_a
    count = 0

    until count == size
      row = []
      row << letters[count]
      size.times { row << " " }
      @working_rows << row
      count += 1
    end
  end

  def print_board
    puts ["\n",@border, @header_row]

    @working_rows.each { |row| print "#{row.join(" ")}\n" }

    puts @border
  end

  def two_ship_location_valid?(head, tail)
    result = not_on_board_check(head,tail)
    result = proximity_check(head,tail)
  end

  def not_on_board_check(head, tail)
    return not_on_board_result unless head.length == 2 && tail.length == 2

    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    row_validity = letters.include?(head_row) && letters.include?(tail_row)
    return not_on_board_result unless row_validity

    numbers = [1, 2, 3, 4]
    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i
    column_validitiy = numbers.include?(head_column) && numbers.include?(tail_column)
    return not_on_board_result unless column_validitiy

    true
  end

  def not_on_board_result
    puts "\nThese positions aren't on the game board.\n"
    false
  end

  def proximity_check(head, tail)
    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]


    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i


  end

end
