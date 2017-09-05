require 'minitest/autorun'
require 'minitest/emoji'

require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_exists
    player_1 = Player.new

    assert_instance_of Player, player_1
  end

  attr_reader :player
  def setup
    @player = Player.new
  end

  def test_player_has_an_owner_board
    assert_instance_of Board, @player.owner_board
  end

  def test_player_has_an_opponent_board
    assert_instance_of Board, @player.opponent_board
  end

  # def test_assign_ships_populates_working_rows_of_owner_board
  #   @player.assign_ships
  #   refute_equal [], @player.owner_board.working_rows
  # end
  #
  # def test_player_has_a_default_user_type_of_human
  #   assert_equal 'human', @player.user_type
  # end
  #
  # def test_assign_ships_calls_methods_to_assign_ships_without_error
  #   skip
  #   @player.assign_ships
  # end
  #
  # def test_ship_assignment_prompt_prints_without_errors
  #   @player.assignment_prompt
  # end
  #
  # def test_assign_two_unit_ship_takes_prompt_from_user_and_holds_them_on_board
  #   @player.assign_two_ship_location
  #
  #   assert_equal 2, @player.owner_board.two_ship_location.count
  # end

end
