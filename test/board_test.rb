require 'minitest/autorun'
require 'minitest/emoji'

require './lib/board'

class BoardTest < Minitest::Test

  def test_board_exists
    board = Board.new

    assert_instance_of Board, board
  end

  attr_reader :board
  def setup
    @board = Board.new
  end

  def test_board_has_size_default_size_of_4
    assert_equal 4, @board.size
  end

  def test_board_is_createed_with_two_empty_arrays_for_player_ship_placement
    assert_equal [], @board.two_ship_location
    assert_equal [], @board.three_ship_location
  end

  def test_create_board_runs_methods_to_create_board_without_error
    @board.create_board
  end

  def test_create_border_creates_boarded_according_to_board_size
    expected = "=========="

    assert_equal expected, @board.create_border(@board.size)
  end

  def test_board_has_default_empty_header_row
    assert_equal [], @board.header_row
  end

  def test_create_header_row_creates_header_according_to_size
    @board.create_header_row(@board.size)

    assert_equal ". 1 2 3 4", @board.header_row
  end

  def test_board_has_default_empty_working_rows
    assert_equal [], @board.working_rows
  end

  def test_create_working_rows_creates_empty_rows_meant_to_lie_beneath_header_row
    expected = [["A", " ", " ", " ", " "],
              ["B", " ", " ", " ", " "],
              ["C", " ", " ", " ", " "],
              ["D", " ", " ", " ", " "]
              ]

    @board.create_working_rows(@board.size)

    assert_equal expected, @board.working_rows
  end

  def test_print_board_prints_board_of_default_size_4_without_error
    @board.create_board
    @board.print_board
  end

  def test_print_board_can_print_a_board_of_size_8_without_error
    new_board = Board.new(8)

    new_board.create_board
    new_board.print_board
  end

end
