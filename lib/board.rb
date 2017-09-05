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
    result = located_on_board_check(head,tail)
    return result if result == false
    result = two_ship_proximity_check(head,tail)
  end

  def located_on_board_check(head, tail)
    return located_on_board_fail unless head.length == 2 && tail.length == 2

    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    row_validity = letters.include?(head_row) && letters.include?(tail_row)
    return located_on_board_fail unless row_validity

    numbers = [1, 2, 3, 4]
    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i
    column_validitiy = numbers.include?(head_column) && numbers.include?(tail_column)
    return located_on_board_fail unless column_validitiy

    true
  end

  def located_on_board_fail
    puts "\nThese positions aren't on the game board.\n"
    false
  end

  def two_ship_proximity_check(head, tail)
    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    row_proximity = (head_row.hex - tail_row.hex).abs
    return proximity_fail unless row_proximity <= 1

    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i
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

  def three_ship_location_valid?(head,tail)
    result = located_on_board_check(head,tail)
    return result if result == false
    result = three_ship_proximity_check(head, tail)
    return result if result == false
    result = three_ship_overlap_check(head,tail)
  end

  def three_ship_proximity_check(head, tail)
    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    row_proximity = (head_row.hex - tail_row.hex).abs

    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i
    column_proximity = (head_column - tail_column).abs

    total_proximity = row_proximity + column_proximity
    return proximity_fail unless total_proximity == 2

    proximity_difference = (row_proximity - column_proximity).abs
    return proximity_fail unless proximity_difference == 2

    true
  end

  def three_ship_overlap_check(head, tail)
    overlap = @two_ship_location.find do |coordinate|
       [head, tail].include?(coordinate)
    end

    return false unless overlap.nil?

    letters = ("A".."D").to_a
    head_row = head.split("")[0]
    tail_row = tail.split("")[0]
    row_proximity = (head_row.hex - tail_row.hex).abs

    head_column = head.split("")[1].to_i
    tail_column = tail.split("")[1].to_i
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

    overlap = @two_ship_location.find do |coordinate|
       [head, middle, tail].include?(coordinate)
    end

    return false unless overlap.nil?

    true
  end

  def three_ship_overlap_fail
    puts "\nThese positions overlap with the two unit ship you previously placed.\n"
    false
  end

end
