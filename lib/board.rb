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

  def validate_location(head, tail, ship_type)
    return off_board_fail unless head.length == 2 && tail.length == 2

    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i

    if ship_type == "two_unit"
      return two_ship_location_valid?(head_row, head_column, tail_row, tail_column)
    elsif ship_type = "three_unit"
      return three_ship_location_valid?(head, tail, head_row, head_column, tail_row, tail_column)
    end
  end

  def two_ship_location_valid?(head_row, head_column, tail_row, tail_column)
    result = off_board_check(head_row, head_column, tail_row, tail_column)
    return result if result == false
    result = two_ship_proximity_check(head_row, head_column, tail_row, tail_column)
  end

  def off_board_check(head_row, head_column, tail_row, tail_column)
    letters = ("A".."D").to_a
    row_validity = letters.include?(head_row) && letters.include?(tail_row)
    return off_board_fail unless row_validity

    numbers = [1, 2, 3, 4]
    column_validitiy = numbers.include?(head_column) && numbers.include?(tail_column)
    return off_board_fail unless column_validitiy

    true
  end

  def off_board_fail
    puts "\nThese positions aren't on the game board.\n"
    false
  end

  def two_ship_proximity_check(head_row, head_column, tail_row, tail_column)
    row_proximity = (head_row.hex - tail_row.hex).abs
    return proximity_fail unless row_proximity <= 1

    column_proximity = (head_column - tail_column).abs
    return proximity_fail unless column_proximity <= 1

    total_proximity = row_proximity + column_proximity
    return proximity_fail if total_proximity == 0 || total_proximity == 2

    true
  end

  def proximity_fail
    puts "\nThese positions aren't horizontally or vertically next to each other.\n"
    false
  end

  def three_ship_location_valid?(head, tail, head_row, head_column, tail_row, tail_column)
    result = off_board_check(head_row, head_column, tail_row, tail_column)
    return result if result == false
    result = three_ship_proximity_check(head_row, head_column, tail_row, tail_column)
    return result if result == false
    result = head_tail_overlap_check(head, tail)
    return result if result == false
    result = ship_middle_overlap_check(head_row, head_column, tail_row, tail_column)
  end

  def three_ship_proximity_check(head_row, head_column, tail_row, tail_column)
    row_proximity = (head_row.hex - tail_row.hex).abs
    column_proximity = (head_column - tail_column).abs

    total_proximity = row_proximity + column_proximity
    return proximity_fail unless total_proximity == 2

    proximity_difference = (row_proximity - column_proximity).abs
    return proximity_fail unless proximity_difference == 2

    true
  end

  def head_tail_overlap_check(head, tail)
    overlap = @two_ship_location.find do |coordinate|
      [head, tail].include?(coordinate)
    end

    return three_ship_overlap_fail unless overlap.nil?
  end

  def ship_middle_overlap_check(head_row, head_column, tail_row, tail_column)
    letters = ("A".."D").to_a
    row_proximity = (head_row.hex - tail_row.hex).abs
    column_proximity = (head_column - tail_column).abs

    if row_proximity == 2
      greater_row = [head_row, tail_row].max
      middle_row = letters[letters.index(greater_row) - 1]
      middle = middle_row + head_column.to_s
    else
      greater_column = [head_column, tail_column].max
      middle_column = greater_column - 1
      middle = middle_column.to_s + head_row
    end

    return three_ship_overlap_fail if @two_ship_location.include?(middle)

    true
  end

  def three_ship_overlap_fail
    puts "\nThese positions overlap with the two unit ship you previously placed.\n"
    false
  end

end
