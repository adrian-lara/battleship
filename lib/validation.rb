require './lib/coordinates'

class Validation

  attr_reader :result, :head, :tail, :middle
  attr_accessor :two_ship_location

  def initialize(head, tail, ship_type, user_type, two_ship_location = nil)
    @head = Coordinates.new(head)
    @tail = Coordinates.new(tail)
    @ship_type = ship_type
    @middle = nil

    @row_proximity = nil
    @column_proximity = nil
    @total_proximity = nil

    @two_ship_location = two_ship_location
    @user_type = user_type

    @result = false
  end

  def setup
    @row_proximity = (@head.row_number - @tail.row_number).abs
    @column_proximity = (@head.column_number - @tail.column_number).abs
    @total_proximity = @row_proximity + @column_proximity
  end

  def perform_validation
    entry_validity = @head.valid? && @tail.valid?
    return @result = off_board_fail unless entry_validity

    setup

    if @ship_type == "two-unit"
      return @result = two_ship_proximity_check?
    elsif @ship_type == "three-unit"
      return @result = three_ship_location_valid?
    end
  end

  def two_ship_proximity_check?
    return proximity_fail unless @row_proximity <= 1
    return proximity_fail unless @column_proximity <= 1
    return proximity_fail if @total_proximity == 0 || @total_proximity == 2
    true
  end

  def three_ship_location_valid?
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
      [@head.location, @tail.location].include?(coordinate)
    end
    return three_ship_overlap_fail unless overlap.nil?
    true
  end

  def ship_middle_overlap_check
    create_middle_for_three_ship
    return three_ship_overlap_fail if @two_ship_location.include?(@middle.location)
    true
  end

  def create_middle_for_three_ship
    if @row_proximity == 2
      greater_row = [@head.row_number, @tail.row_number].max
      middle_row = ["A", "B", "C", "D"][greater_row - 1]
      middle_column = @head.column_number.to_s
    else
      greater_column = [@head.column_number, @tail.column_number].max
      middle_column = (greater_column - 1).to_s
      middle_row = ["A", "B", "C", "D"][@head.row_number]
    end

    @middle = Coordinates.new(middle_row + middle_column)
  end

  def proximity_fail
    puts "\nThese positions aren't horizontally or vertically close enough to each other.\n" if @user_type == "User"
    false
  end

  def three_ship_overlap_fail
    puts "\nThese positions overlap with the two unit ship you previously placed.\n" if @user_type == "User"
    false
  end

  def off_board_fail
    puts "\nThese positions aren't valid positions on the game board.\n" if @user_type == "User"
    false
  end

end
