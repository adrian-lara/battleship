require './lib/board'

class Validation

  attr_reader :result
  attr_accessor :two_ship_location

  def initialize(head, tail, ship_type, two_ship_location = nil)
    @head = head
    @tail = tail
    @ship_type = ship_type
    @head_row = nil
    @tail_row = nil
    @head_column = nil
    @tail_column = nil

    @row_proximity = nil
    @column_proximity = nil
    @total_proximity = nil

    @two_ship_location = two_ship_location

    @result = false
  end

  def setup
    @head_row = @head.split("")[0].upcase
    @tail_row = @tail.split("")[0].upcase
    @head_column = @head.split("")[1].to_i
    @tail_column = @tail.split("")[1].to_i

    @row_proximity = (@head_row.hex - @tail_row.hex).abs
    @column_proximity = (@head_column - @tail_column).abs
    @total_proximity = @row_proximity + @column_proximity
  end

#rename valid_location?
  def perform_validation
    setup

    return @result = off_board_fail unless @head.length == 2 && @tail.length == 2

    if @ship_type == "two-unit"
      return @result = two_ship_location_valid?
    elsif @ship_type == "three-unit"
      return @result = three_ship_location_valid?
    end
  end

  def two_ship_location_valid?()
    result = off_board_check
    return result if result == false
    result = two_ship_proximity_check
  end

  def off_board_check
    letters = ("A".."D").to_a
    row_validity = letters.include?(@head_row) && letters.include?(@tail_row)
    return off_board_fail unless row_validity

    numbers = [1, 2, 3, 4]
    column_validitiy = numbers.include?(@head_column) && numbers.include?(@tail_column)
    return off_board_fail unless column_validitiy

    true
  end

  def off_board_fail
    puts "\nThese positions aren't on the game board.\n"
    false
  end

  def two_ship_proximity_check
    return proximity_fail unless @row_proximity <= 1
    return proximity_fail unless @column_proximity <= 1
    return proximity_fail if @total_proximity == 0 || @total_proximity == 2

    true
  end

  def proximity_fail
    puts "\nThese positions aren't horizontally or vertically next to each other.\n"
    false
  end

  def three_ship_location_valid?
    result = off_board_check
    return result if result == false
    result = three_ship_proximity_check
    return result if result == false
    result = head_tail_overlap_check
    return result if result == false
    result = ship_middle_overlap_check
  end

  def three_ship_proximity_check
    return proximity_fail unless @total_proximity == 2

    proximity_difference = (@row_proximity - @column_proximity).abs
    return proximity_fail unless proximity_difference == 2

    true
  end

  def head_tail_overlap_check
    overlap = @two_ship_location.find do |coordinate|
      [@head, @tail].include?(coordinate)
    end

    return three_ship_overlap_fail unless overlap.nil?
  end

  def ship_middle_overlap_check
    letters = ("A".."D").to_a
    if @row_proximity == 2
      greater_row = [@head_row, @tail_row].max
      middle_row = letters[letters.index(greater_row) - 1]
      middle = middle_row + @head_column.to_s
    else
      greater_column = [@head_column, @tail_column].max
      middle_column = greater_column - 1
      middle = middle_column.to_s + @head_row
    end

    return three_ship_overlap_fail if @two_ship_location.include?(middle)

    true
  end

  def three_ship_overlap_fail
    puts "\nThese positions overlap with the two unit ship you previously placed.\n"
    false
  end

end
