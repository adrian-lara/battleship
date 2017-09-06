require 'minitest/autorun'
require 'minitest/emoji'

require './lib/turn'
require './lib/board'

class TurnTest < Minitest::Test

  attr_reader :turn, :board

  def setup
    @turn = Turn.new("A1")
    @board = Board.new
    @board.two_ship_location = ["A1", "A2"]
    @board.three_ship_location = ["B1", "B2", "B3"]
  end

  def test_turn_class_exists
    assert_instance_of Turn, @turn
  end

  def test_turn_class_has_a_shot_coordinate
    assert_equal "A1", @turn.shot
  end

  def test_result_can_return_either_hit_or_miss
    assert_equal "hit", @turn.result(@board)

    turn1 = Turn.new("B1")
    assert_equal "hit", turn1.result(@board)

    turn2 = Turn.new("B4")
    assert_equal "miss", turn2.result(@board)
  end

end
